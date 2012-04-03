From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 03 Apr 2012 18:08:35 +0300
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <4F7B0C70.2040005@compulab.co.il>
References: <1333456258.38206.YahooMailClassic@web29003.mail.ird.yahoo.com>
 <4F7B0C70.2040005@compulab.co.il>
Message-ID: <4F7B1273.6020003@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hmmm....
If we change the GPSR and GPCR, the old levels should be reserved, right?
Attached...


-- 
Regards,
Igor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pxa2xx-mfp2.patch
Type: text/x-patch
Size: 1444 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120403/c3e05cd2/attachment.bin>
