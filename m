From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 May 2016 10:29:38 +0200
Subject: [PATCH 3/3] ARM: dts: sun5i: Add spi2 alias on A10s Olinuxino
In-Reply-To: <df27dbe5931dcb7d8f404759ad42e25b15bcf780.1464129859.git.hramrach@gmail.com>
References: <908ed06eb46f2162e222258aa14df545d0fa5b48.1464129859.git.hramrach@gmail.com>
 <df27dbe5931dcb7d8f404759ad42e25b15bcf780.1464129859.git.hramrach@gmail.com>
Message-ID: <20160530082938.GE4247@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 07:25:24PM -0000, Michal Suchanek wrote:
> spi2 is available on the UEXT connector
> 
> The bus is named spi2 in the A10s manual and Olinuxino manual so it is
> pointless to alias it to something else like spi0.

That's not how aliases work in the DT. It's about indexing the devices
that are enabled on the board, so it should definitely be 0,
especially since it's the only SPI bus usable on that board anyway.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/b64821f6/attachment.sig>
