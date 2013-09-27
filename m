From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 27 Sep 2013 23:04:24 +0200
Subject: [PATCH v2] misc: (at24) move header to linux/platform_data/
In-Reply-To: <1380308788-15730-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1380308788-15730-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Message-ID: <20130927210424.GA17407@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 03:06:28PM -0400, Vivien Didelot wrote:
> This patch moves the at24.h header from include/linux/i2c to
> include/linux/platform_data and updates existing support accordingly.
> 
> It also fixes the following checkpatch warning:
> 
>     WARNING: please, no space before tabs
>     #436: FILE: include/linux/platform_data/at24.h:31:
>     + * ^Iu8 *mac_addr = ethernet_pdata->mac_addr;$
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/c700734b/attachment.sig>
