From: ajellisuk@yahoo.co.uk (Ellis Andrew)
Date: Fri, 14 Sep 2012 16:55:08 +0100 (BST)
Subject: Kernel fails to boot with "crc error -- System halted"
Message-ID: <1347638108.3789.YahooMailNeo@web133202.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I have run into a major problem in that when I program my kernel into 
flash on my system or try and run it from RAM I get the following 
output:

## Booting image at 00060000 ...
## Copy image from flash 00060000 to ram 00200000 ...
Image Name:
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    1871640 Bytes =  1.8 MB
Load Address: 00008000
Entry Point:  00008000
Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux.............................................  
..................................................  ....................

crc error

-- System halted


The checksum passes, but the image type is uncompressed, so why is the kernel trying to decompress?

>From a successful build I had the same message about uncompressing the 
kernel, so I don't understand what the problem is. I have previously 
been able to build and run kernels without the above problem. I cannot 
work out what I have done to cause this problem, could someone please 
enlighten me as to what could be going wrong?

Kind regards

Andrew 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120914/119309fc/attachment-0001.html>
