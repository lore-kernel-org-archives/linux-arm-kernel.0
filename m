From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 10:20:23 +0100
Subject: [PATCH v5 06/11] ARM: pxa: remove head file in plat-pxa
In-Reply-To: <1318858517-22494-7-git-send-email-haojian.zhuang@marvell.com>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
	<1318858517-22494-7-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111027092023.GF19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 09:35:12PM +0800, Haojian Zhuang wrote:
> Use generic API for gpio read and write. So head file in plat-pxa could
> be removed.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

The previous patch in the series removes all references to this file, so
shouldn't it be combined with the previous patch - or maybe the removal
of references to this file should be combined with this patch instead.

Either way, it looks odd to remove all references to this file in a
separate patch, and then delete the file separately.  (Partly because
the description in the commit log doesn't make sense.)
