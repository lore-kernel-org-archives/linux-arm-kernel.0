From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Jul 2013 15:03:54 +0300
Subject: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
In-Reply-To: <51DBF98B.1050104@ti.com>
References: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
 <20130709102022.GH5552@arwen.pp.htv.fi> <51DBF23F.20103@ti.com>
 <20130709112751.GI5552@arwen.pp.htv.fi> <51DBF98B.1050104@ti.com>
Message-ID: <20130709120354.GP5552@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 09, 2013 at 05:22:43PM +0530, George Cherian wrote:
> >>>Another thing: am437x has 4 instances of this IP, why are you adding
> >>>only one ?
> >>AM437x has got only 2 instances. I have verified only one on HAPS so
> >>adding only one.
> >weird, on my TRM I see for dwc3 but 2 PHYs.
> 
> Please confirm whether you are looking at am437x TRM or dra7x TRM?
> dra7x has 4 dwc3 and 2 internal  phys and 2 external phys

guilty as charged :-)

> >>>And why aren't you pasing the PHY nodes here ? The device
> >>>won't work without its PHYs.
> >>Yes true, again in HAPS I  didnt have any PHY configuration to be done.
> >alright, but we should still pass the PHY right ? once silicon comes,
> >we want this to work without any further changers.
> 
> okay will add phy nodes and 2 instances of dwc3.

thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/1efa2643/attachment.sig>
