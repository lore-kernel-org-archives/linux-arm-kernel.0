From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Aug 2015 14:58:51 +0200
Subject: [PATCH 0/5] clk: sunxi: Fix module autoload for OF platform driver
In-Reply-To: <20150828124222.GA24923@goodgumbo.baconseed.org>
References: <20150828124222.GA24923@goodgumbo.baconseed.org>
Message-ID: <20150828125851.GO29389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 02:42:22PM +0200, Luis de Bethencourt wrote:
> Hello,
> 
> This series add the missing MODULE_DEVICE_TABLE() for OF to eport
> that information so modules have the correct aliases built-in
> and autoloading works correctly.
> 
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519

On the whole serie,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Mike, Stephen, can you apply them directly as fixes for 4.3 ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/9b893158/attachment-0001.sig>
