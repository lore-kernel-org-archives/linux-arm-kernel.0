From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Jun 2017 08:37:52 +0200
Subject: [PATCH v6 00/21] net-next: stmmac: add dwmac-sun8i ethernet driver
In-Reply-To: <20170601.145819.789604139072328057.davem@davemloft.net>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
 <20170601.145819.789604139072328057.davem@davemloft.net>
Message-ID: <20170602063752.aqyvwcykvepiyt4y@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 02:58:19PM -0400, David Miller wrote:
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> Date: Wed, 31 May 2017 09:18:31 +0200
> 
> > This patch series add the driver for dwmac-sun8i which handle the Ethernet MAC
> > present on Allwinner H3/H5/A83T/A64 SoCs.
> 
> Series applied, but wow that's a lot of DT file changes :-(

The DT patches should not go through your tree, but arm-soc, so I
guess this is not an issue for you?

Maximee

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170602/68bcf6b2/attachment-0001.sig>
