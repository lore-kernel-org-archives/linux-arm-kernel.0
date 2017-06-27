From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Jun 2017 12:15:50 +0200
Subject: [PATCH v2] ARM: dts: sun7i: Add A20 LCD0 RGB888 pins
In-Reply-To: <20170626125506.21063-1-net147@gmail.com>
References: <20170626125506.21063-1-net147@gmail.com>
Message-ID: <20170627101550.mr3qp5dgazbm7lsy@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 26, 2017 at 10:55:06PM +1000, Jonathan Liu wrote:
> The LCD0 controller on the A20 can do RGB output up to 8 bits per
> channel. Add the pins for RGB888 output.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

We're not merging those patches if it's not used by any boards in
tree.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170627/ac678324/attachment.sig>
