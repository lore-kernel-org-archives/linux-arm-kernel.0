From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Jun 2017 19:13:42 +0200
Subject: [PATCH v3 1/3] input: sun4i-a10-lradc-keys: Add support for A83T
In-Reply-To: <20170624024515.4669-2-techping.chan@gmail.com>
References: <20170624024515.4669-1-techping.chan@gmail.com>
 <20170624024515.4669-2-techping.chan@gmail.com>
Message-ID: <20170626171342.pdr7xdiaki4i5bdt@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 24, 2017 at 10:45:13AM +0800, Ziping Chen wrote:
> From: Ziping Chen <techping.chan@gmail.com>
> 
> Allwinner A83T SoC has a low res adc like the one
> in Allwinner A10 SoC, however, the A10 SoC's vref
> of lradc internally is divided by 2/3 and the A83T
> SoC's vref of lradc internally is divided by 3/4,
> thus add a hardware variant for it to be compatible
> with various devices.
> 
> Signed-off-by: Ziping Chen <techping.chan@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/bc41849d/attachment.sig>
