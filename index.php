<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, DELETE, POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");
// Koneksi ke database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wikiwow";
$conn = new mysqli(
    $servername,
    $username,
    $password,
    $dbname
);
if ($conn->connect_error) {
    die("Koneksi ke database gagal: " . $conn->connect_error);
}

$method = $_SERVER["REQUEST_METHOD"];
if ($method === "GET") {

    $sql = "SELECT * FROM jurusan";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $kontak = array();
        while ($row = $result->fetch_assoc()) {
            $kontak[] = $row;
        }
        echo json_encode($kontak);
    } else {
        echo "Data jurusan kosong.";
    }
}

// if ($method === "POST") {
//     // Menambahkan data kontak
//     $data = json_decode(file_get_contents("php://input"), true);
//     $nama = $data["nama"];
//     $noTelp = $data["no_telp"];
//     $email = $data["email"];
//     if (!empty($nama) && !empty($noTelp) && !empty($email)) {
//         $sql = "INSERT INTO kontak (nama, no_telp, email) VALUES ('$nama', '$noTelp', '$email')";
//         if ($conn->query($sql) === TRUE) {
//             $response['pesan'] = 'berhasil';
//           //  http_response_code(201); // Created
//         } else {
//             $response['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
//             http_response_code(500); // Internal Server Error
//         }
//     } else {
//         $response['pesan'] = "Semua kolom harus diisi.";
//         http_response_code(400); // Bad Request
//     }
//     echo json_encode($response);
// }

// if ($method === "PUT") {
//     // Memperbarui data kontak
//     $data = json_decode(file_get_contents("php://input"), true);
//     $id = $data["id"];
//     $nama = $data["nama"];
//     $noTelp = $data["no_telp"];
//     $email = $data["email"];
//     $sql = "UPDATE kontak SET nama='$nama', no_telp='$noTelp', email='$email' WHERE id=$id";
//     if ($conn->query($sql) === TRUE) {
//         $response['pesan'] = 'berhasil';
//     } else {
//         $response['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
//         http_response_code(500); // Internal Server Error
//     }
//     echo json_encode($response);
// }

// if ($method === "DELETE") {
//     // Menghapus data kontak
//     $id = $_GET["id"];
//     $sql = "DELETE FROM kontak WHERE id=$id";
//     if ($conn->query($sql) === TRUE) {
//         $response['pesan'] = 'berhasil';
//     } else {
//         $response['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
//         http_response_code(500); // Internal Server Error
//     }
//     echo json_encode($response);
// }

$conn->close();