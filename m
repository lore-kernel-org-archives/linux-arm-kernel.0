From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Feb 2010 11:24:24 -0800
Subject: [PATCH v2] omap: Remove DEBUGFS dependency for mux name checking
In-Reply-To: <1266427021-10990-1-git-send-email-ranjithl@ti.com>
References: <1266427021-10990-1-git-send-email-ranjithl@ti.com>
Message-ID: <20100217192423.GA21755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ranjith Lohithakshan <ranjithl@ti.com> [100217 09:14]:
> The check for a valid mux name should be performed regardless of whether
> DEBUGFS is enabled or not.
> 
> This fixes the issue currently seen with boards not booting up
> if DEBUGFS is not enabled in defconfig.
> 
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Thanks, I've updated the description a bit to include the error
and added the patch into omap-fixes-for-linus.

Updated patch below.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fix-mux-debufs.patch
Type: text/x-diff
Size: 1871 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100217/738ff7aa/attachment.bin>
