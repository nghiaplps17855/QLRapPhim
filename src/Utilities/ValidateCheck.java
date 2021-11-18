package Utilities;

import static Utilities.XDate.formater;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.swing.JOptionPane;

public class ValidateCheck implements Serializable {
//Check Null & Max Length String

    static SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yyyy");

    public boolean CheckString(String NameString, String string, int length, boolean constraint) {
        if (constraint) {
            if (string.equals("")) {
                JOptionPane.showMessageDialog(null, NameString + " Đang Để Trống!", "Lỗi", 0);
                return false;
            }
            if (string.length() != length) {
                JOptionPane.showMessageDialog(null, NameString + " Phải Dài " + length + " Kí Tự!", "Lỗi", 0);
                return false;
            } else {
                return true;
            }
        } else if (constraint == false) {
            if (string.equals("")) {
                JOptionPane.showMessageDialog(null, NameString + " Đang Để Trống!", "Lỗi", 0);
                return false;
            }
            if (string.length() > length && length != -1) {
                JOptionPane.showMessageDialog(null, NameString + " Quá Dài!", "Lỗi", 0);
                return false;
            } else {
                return true;
            }
        }
        return false;
    }
//Check Duplicase Key

    public boolean CheckDulicase(String NameStringAfter, String string, String NameStringBefore, String string1) {
        if (string.equals(string1)) {
            JOptionPane.showMessageDialog(null, NameStringAfter + " Trùng Mã Với " + NameStringBefore + "!", "Lỗi", 0);
            return false;
        }
        return true;
    }
//Check String to Float 

    public boolean CheckFloat(String NameString, String string) {
        try {
            Float x = Float.parseFloat(string);
            return true;
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, NameString + " Nhập Vào Sai Kiểu Dữ Liệu!", "Lỗi", 0);
            return false;
        }
    }
//Check String to Date

    public boolean CheckDate(String NameString, String string) {
        try {
            Date CheckDate = formater.parse(string);
            return true;
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, NameString + " Nhập Vào Sai Kiểu Dữ Liệu!", "Lỗi", 0);
            return false;
        }
    }
//Check Null Date

    public boolean CheckNullDate(String NameString, Date date) {
        if (date == null) {
            JOptionPane.showMessageDialog(null, NameString + " Để Trống!", "Lỗi", 0);
            return false;
        }
        return true;
    }
//Check Date After And Before

    public boolean CheckAfterAndBefore(String NameStringAfter, Date after, String NameStringBefore, Date before) {
        if (after.getYear() <= before.getYear()) {
            if (after.getYear() == before.getYear()) {
                if (after.getMonth() <= before.getMonth()) {
                    if (after.getMonth() == before.getMonth()) {
                        if (after.getDay() <= before.getDay()) {
                            return true;
                        }
                    }
                    if (after.getMonth() < before.getMonth()) {
                        return true;
                    }
                }
            }
            if (after.getYear() < before.getYear()) {
                return true;
            }
        }
        JOptionPane.showMessageDialog(null, NameStringAfter + " Sau Ngày " + NameStringBefore + "!", "Lỗi", 0);
        return false;
    }
}