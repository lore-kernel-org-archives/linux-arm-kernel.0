From: balbi@ti.com (Felipe Balbi)
Date: Mon, 8 Jul 2013 10:41:33 +0300
Subject: [PATCH 1/4] usb: gadget: s3c-hsotg: Allow driver instantiation
 using device tree
In-Reply-To: <1372174706-5459-2-git-send-email-t.figa@samsung.com>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
 <1372174706-5459-2-git-send-email-t.figa@samsung.com>
Message-ID: <20130708074133.GC16635@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 25, 2013 at 05:38:23PM +0200, Tomasz Figa wrote:
> This patch adds OF match table to the driver to allow instantiating it
> using device tree.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I will take this one only, the others have no dependency on this.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/d89b23b8/attachment.sig>
