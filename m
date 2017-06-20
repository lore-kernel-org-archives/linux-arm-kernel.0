From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jun 2017 11:49:06 +0200
Subject: [PATCH 2/3] ARM: dts: sunxi: add MMC support for A83T
In-Reply-To: <20170618130018.10684-2-techping.chan@gmail.com>
References: <20170618130018.10684-1-techping.chan@gmail.com>
 <20170618130018.10684-2-techping.chan@gmail.com>
Message-ID: <20170620094906.7bwg6zvth6oqkasd@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 18, 2017 at 09:00:17PM +0800, Ziping Chen wrote:
> From: Ziping Chen <techping.chan@gmail.com>
> 
> The Allwinner A83T's MMC can work with
> compatible "allwinner,sun7i-a20-mmc".
> 
> Add support for it.

This has been proven not to be the case already.

Please use an A83T compatible only.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/47fd9d34/attachment.sig>
