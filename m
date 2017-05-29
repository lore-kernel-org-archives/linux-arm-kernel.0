From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 10:30:15 +0200
Subject: [PATCH v3 1/1] ARM: dts: orange-pi-zero: add node for SPI NOR
In-Reply-To: <20170528103026.6396-2-geomatsi@gmail.com>
References: <20170528103026.6396-1-geomatsi@gmail.com>
 <20170528103026.6396-2-geomatsi@gmail.com>
Message-ID: <20170529083015.64kwhnzz7wh6d36g@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 28, 2017 at 01:30:26PM +0300, Sergey Matyukevich wrote:
> Add node for SPI NOR flash on orange-pi-zero board. Disable this node
> by default and leave it to users to enable it if their board has
> SPI NOR flash chip populated.
> 
> SPI NOR flash was optional in the first production batch in Dec 2016.
> In later batches flash chip was pre-populated. However there should
> be quite a few boards around which do not have flash chip.
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

Merged, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/bee06885/attachment-0001.sig>
