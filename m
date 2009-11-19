From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 19 Nov 2009 10:04:10 +0200
Subject: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from Arnaud
	Patard.
In-Reply-To: <20091118232948.063635416@fluff.org.uk>
References: <20091118232939.201290297@fluff.org.uk>
	<20091118232948.063635416@fluff.org.uk>
Message-ID: <200911191004.16315.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 19 ?????? 2009 1:29:40 ????? Ben Dooks ???????:
<skipped>
> +	/* Initialise registers */
> +	if ((info->delay & 0xffff) > 0)
> +		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);

As for me, it's not OK to modity ADC-related registers in touchscreen driver, 
adc driver should be modified to support delay.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091119/5890c791/attachment.sig>
