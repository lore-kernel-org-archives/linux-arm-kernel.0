From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Jul 2017 22:46:46 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: add a missing function of A10/A20
 pinctrl driver
In-Reply-To: <20170706142822.20296-2-icenowy@aosc.io>
References: <20170706142822.20296-1-icenowy@aosc.io>
 <20170706142822.20296-2-icenowy@aosc.io>
Message-ID: <20170706204646.3akr57fo6c2ok4wn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 06, 2017 at 10:28:21PM +0800, Icenowy Zheng wrote:
> The PH16 pin has a function with mux id 0x5, which is the DET pin of the
> "sim" (smart card reader) IP block.
> 
> This function is missing both in the old A10 and A20 drivers, so it's
> not found during the merge of these two drivers.
> 
> Add it to the driver. As we now merged A20 pinctrl driver to the A10
> one, we need to only fix the A10 driver now.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

I'm not sure what you mean there. It's not mentionned in the A10
datasheet, and neither in the A20. Where did you get that info from?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/fbceadd2/attachment.sig>
