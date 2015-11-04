From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Nov 2015 07:51:11 -0800
Subject: [patch] bus: sunxi-rsb: unlock on error in sunxi_rsb_read()
In-Reply-To: <20151103220244.GA19280@mwanda>
References: <20151103220244.GA19280@mwanda>
Message-ID: <20151104155111.GU6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Wed, Nov 04, 2015 at 01:02:44AM +0300, Dan Carpenter wrote:
> Don't forget to unlock before returning an error code.
> 
> Fixes: d787dcdb9c8f ('bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I just queued this for 4.4, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/43b0f17f/attachment.sig>
