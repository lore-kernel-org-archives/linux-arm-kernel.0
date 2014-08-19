From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 20 Aug 2014 01:23:45 +1000
Subject: Lock Directory failure
In-Reply-To: <alpine.LSU.2.11.1408181350260.1127@eggly.anvils>
References: <20140818163209.GJ9662@saruman.home>
 <alpine.LSU.2.11.1408181350260.1127@eggly.anvils>
Message-ID: <20140820012345.7c358fd7@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugh,

On Mon, 18 Aug 2014 13:58:26 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
>
> [PATCH next] vfs: initialize m_list to fix crash in mnt_set_mountpoint
> 
> Fix mnt_set_mountpoint() crash: new_mountpoint() must initialize m_list.
> 
> Reported-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>

I assume that this is a fix for commit 89f7ca1af15b ("vfs: Keep a list
of mounts on a mount point") that is currently i the vfs tree.  I will
apply this patch as a fix up for the vfs tree in linux-next today.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/d778aa76/attachment.sig>
