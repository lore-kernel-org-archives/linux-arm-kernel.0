From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 16:40:35 +0100
Subject: [PATCH 1/1] arm: sunxi: Add alternative pins for spi0
In-Reply-To: <1513151074-6888-1-git-send-email-stefan@olimex.com>
References: <1513151074-6888-1-git-send-email-stefan@olimex.com>
Message-ID: <20171213154035.qc655iahjoeflftq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 13, 2017 at 09:44:34AM +0200, Stefan Mavrodiev wrote:
> Allwinner A10/A13/A20 SoCs have pinmux for spi0
> on port C. The patch adds these pins in the respective
> dts includes.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Do you have any boards that are using these?

We won't merge that patch if there's no users for it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/6c0122b7/attachment.sig>
