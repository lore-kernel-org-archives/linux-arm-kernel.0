From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Oct 2009 17:19:30 +0300
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
Message-ID: <200910201719.41102.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix for a bug that shows when the s3c2410 TS driver requests
a conversion from the s3c-adc driver and the machine goes into suspend.
In this case the touchscreen stops working.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-s3c24xx-adc-resume-convertions-interrupted-by-going-.patch
Type: text/x-patch
Size: 3617 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091020/e97caad8/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091020/e97caad8/attachment.sig>
