From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 Jan 2017 20:25:52 +0200
Subject: [PATCH] usb: dwc3-exynos fix unspecified suspend clk error
 handling
In-Reply-To: <5156028.4V9iLD3Qkj@amdc3058>
References: <20170110022131.31042-1-shuahkh@osg.samsung.com>
 <8784459.rxWqZlDLVg@amdc3058>
 <28815306-e220-4847-99ce-b058baae0d07@osg.samsung.com>
 <CGME20170110170942epcas1p3decee28366d7d42b70e7b0669b97326f@epcas1p3.samsung.com>
 <5156028.4V9iLD3Qkj@amdc3058>
Message-ID: <20170110182552.coom4p6dpdqo2ljv@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 06:09:40PM +0100, Bartlomiej Zolnierkiewicz wrote:
> BTW What is interesting is that the Exynos7 dts patch [2] has never
> made it into upstream for some reason.  In the meantime however
> Exynos5433 (similar to Exynos7 to some degree) became the user of
> susp_clk.
> 
> [1] https://lkml.org/lkml/2014/11/21/247
> [2] https://patchwork.kernel.org/patch/5355161/
>

+Cc Alim and Pankaj,

Anyone would like to resend [2] after rebasing and testing? Interrupt
flags would have to be fixed and status=disabled added.

Best regards,
Krzysztof
