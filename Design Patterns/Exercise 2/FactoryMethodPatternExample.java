//Interface for document
interface Document{
    void open();
    void close();
    void save();
}

//Concrete Document classes
class WordDocument implements Document{
    @Override
    public void open(){
        System.out.println("Opening Word Document");
    }
    public void close(){
        System.out.println("Closing Word Document");
    }
    public void save(){
        System.out.println("Saving Word Document");
    }
}

class PdfDocument implements Document{
    @Override
    public void open(){
        System.out.println("Opening Pdf Document");
    }
    public void close(){
        System.out.println("Closing Pdf Document");
    }
    public void save(){
        System.out.println("Saving Pdf Document");
    }
}

class ExcelDocument implements Document{
    @Override
    public void open(){
        System.out.println("Opening Excel Document");
    }
    public void close(){
        System.out.println("Closing Excel Document");
    }
    public void save(){
        System.out.println("Saving Excel Document");
    }
}

//abstract factory class
abstract class DocumentFactory{
    public abstract Document createDocument();
}

//Concrete Factory classes
class WordFactoryDocument extends DocumentFactory{
    @Override
    public Document createDocument(){
        return new WordDocument();
    }
}

class PdfFactoryDocument extends DocumentFactory{
    @Override
    public Document createDocument(){
        return new PdfDocument();
    }
}

class ExcelFactoryDocument extends DocumentFactory{
    @Override
    public Document createDocument(){
        return new ExcelDocument();
    }
}

public class FactoryMethodPatternExample{
    public static void main(String[] args){

        //Create factories
        DocumentFactory wordfactory = new WordFactoryDocument();
        DocumentFactory pdffactory = new PdfFactoryDocument();
        DocumentFactory excelfactory = new ExcelFactoryDocument();

        //Creating documents using factories
        Document word = wordfactory.createDocument();
        Document pdf = pdffactory.createDocument();
        Document excel = excelfactory.createDocument();

        word.open();
        word.save();
        word.close();

        pdf.open();
        pdf.save();
        pdf.close();

        excel.open();
        excel.save();
        excel.close();
    }
}