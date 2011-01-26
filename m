From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Wed, 26 Jan 2011 19:57:04 +0000
Subject: SDMA on imx35
In-Reply-To: <201101261224.37260.alexander.stein@systec-electronic.com>
References: <201101261224.37260.alexander.stein@systec-electronic.com>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA126F19@039-SN1MPN1-005.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

>-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-
>bounces at lists.infradead.org] On Behalf Of Alexander Stein
>Sent: Wednesday, January 26, 2011 5:25 AM
>To: linux-arm-kernel at lists.infradead.org
>Subject: SDMA on imx35
>
>Hello,
>
>I'm currently fiddling on SDMA support for the uart driver on my imx35 rev2.
>TX is working great, no problems so far. But on RX I never get the SDMA
>interrupt that the request has been processed.
>So I'm wondering if the UART-DMS-Script in ROM is actually working. Has
>anybody get this to work (doesn't matter if linux-2.6 from git or kernel from
>freescale)?

I'm also looking at enabling SDMA support for the imx-uart on MX51. Should be the same driver. Unfortunately, I'm not at your stage of _working_ yet, so I can't comment on your RX problem. I know that internally, we haven't had any issue with RX on uart with SDMA, but FSL's SDMA implementation is quite different(part of my problem is taking the time to understand how to use dmaengine) from kernel.org. 

Do you have a patch to share?

Thanks,

Dinh

>
>Best regards,
>Alexander
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
