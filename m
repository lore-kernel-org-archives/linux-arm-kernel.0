From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Aug 2015 18:10:55 +0200
Subject: [PATCH 0/8] misc: remove boundary checks from bin attr users
In-Reply-To: <1437945502-27944-1-git-send-email-vz@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
Message-ID: <20150807161055.GD25357@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir,

On Mon, Jul 27, 2015 at 12:18:22AM +0300, Vladimir Zapolskiy wrote:
> This change removes a number of redundant checks on bin attribute
> client's side, the same checks are done by sysfs_kf_bin_read() or
> sysfs_kf_bin_write() caller from fs/sysfs/file.c.
> 
> Note, drivers/misc/pch_phub.c and drivers/misc/c2port/core.c may be
> updated in a similar way, however this task is not done due to more
> complicated read()/write() callbacks.

Can you resend the patches which touch i2c drivers with me on cc? I'd
like to take care of them.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/fe9bc9a6/attachment.sig>
