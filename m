From: a_bouin@yahoo.fr (Aurelien Bouin)
Date: Thu, 10 Nov 2011 09:06:38 +0000 (GMT)
Subject: [PATCH] Proposed patch for USB and RS485 on imx board
Message-ID: <1320915998.92232.YahooMailNeo@web28513.mail.ukl.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Attached are two patches :?
- imx_rs485_support.patch : Implement the RS485 on imx board... like describe in the kernel documentation : linux/Documentation/serial/serial-rs485.txt
- imx_solve_compilation_problem_with_mx27.patch : Solve a compilation problem when using host USB port with mx27 boards

Feel free to contact me if you have any problem in merging them,

Thank you,

Aurelien BOUIN
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/46bbb5a8/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx_solve_compilation_problem_with_mx27.patch
Type: application/octet-stream
Size: 330 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/46bbb5a8/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx_rs485_support.patch
Type: application/octet-stream
Size: 6344 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/46bbb5a8/attachment-0001.obj>
