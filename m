From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 22 Oct 2009 14:10:23 +0300
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
In-Reply-To: <200910201719.41102.anarsoul@gmail.com>
References: <200910201719.41102.anarsoul@gmail.com>
Message-ID: <200910221410.28632.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 20 ??????? 2009 17:19:30 ????? Vasily Khoruzhick ???????:
> Fix for a bug that shows when the s3c2410 TS driver requests
> a conversion from the s3c-adc driver and the machine goes into suspend.
> In this case the touchscreen stops working.

Does anyone on maillist interested in this bugfix? I got no response for 2 
days... 

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091022/3eabe1d6/attachment.sig>
