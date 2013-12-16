From: marex@denx.de (Marek Vasut)
Date: Mon, 16 Dec 2013 20:54:36 +0100
Subject: [PATCH V1 03/11] ARM: dts: imx6qdl-sabrelite: remove usdhc4
 wp-gpio
In-Reply-To: <52AF57A6.5090203@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <20131214134656.GC16177@S2101-09.ap.freescale.net>
 <52AF57A6.5090203@boundarydevices.com>
Message-ID: <201312162054.36699.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 16, 2013 at 08:42:30 PM, Troy Kisky wrote:
> On 12/14/2013 6:46 AM, Shawn Guo wrote:
> > On Thu, Dec 12, 2013 at 06:49:07PM -0700, Troy Kisky wrote:
> >> On Sabre Lite usdhc4 is a micro sd slot, which has no
> >> write protect.
> >> 
> >> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > 
> > Applied #1, #2 and #3, thanks.
> > 
> > Shawn
> 
> Thanks for the rebase on Marek's PCIe patch. However, PCIe is a common
> feature
> and should be moved to imx6qdl-sabrelite.dtsi.
> 
> Should I send a patch to do this, or will you fix it up, or will Marek?

I will gladly let such a privilege slip, I am overloaded like hell :(

Best regards,
Marek Vasut
