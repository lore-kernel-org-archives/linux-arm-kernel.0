From: hongjiujing@126.com (tommy.hong)
Date: Fri, 28 Aug 2009 21:09:17 +0800 (CST)
Subject: Latest Samsung soc s3c6410 fb1 test failed
Message-ID: <32366586.1033641251464957952.JavaMail.coremail@bj126app18.126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,all!

I am tommy,i have test samsung soc kernelfor s3c6410 ,code is from kernel.git(samsung-ap-2.6)!

Now i met a question about s3c6410 framerbuffer fb1 test !

I try to test fb1 !attachment is my test C file!


1st test:
 ./fb1-test /dev/fb1 0 0 200 200

LCD draw operation result is wrong!!

2nd test:

 ./fb1-test /dev/fb1 0 0 200 200

LCD draw operation result is write!

is it my test file wrong or driver missed some issue?

thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090828/027b2a1f/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fb-test1.tar.gz
Type: application/x-gzip
Size: 10847 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090828/027b2a1f/attachment-0001.gz>
