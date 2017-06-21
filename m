From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jun 2017 22:35:02 +0200
Subject: [PATCH v2 1/3] input: sun4i-a10-lradc-keys: Add support for A83T
In-Reply-To: <20170620134445.23097-2-techping.chan@gmail.com>
References: <20170620134445.23097-1-techping.chan@gmail.com>
 <20170620134445.23097-2-techping.chan@gmail.com>
Message-ID: <20170621203502.ng7auh6vfmibobwo@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 09:44:43PM +0800, Ziping Chen wrote:
> From: Ziping Chen <techping.chan@gmail.com>
> 
> Allwinner A83T SoC has a low res adc like the one
> in Allwinner A10 SoC, however, the A10 SoC's vref
> of lradc internally is divided by 2/3 and the A83T
> SoC's isn't, thus add a hardware variant for it to
> be compatible with various devices.

Where did you get that info from?

Judging from the user manual, the threshold is actually set to 3/4,
and not 2/3, but there's still one.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/19305b2d/attachment-0001.sig>
