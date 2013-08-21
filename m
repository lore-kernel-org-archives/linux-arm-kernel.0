From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 21 Aug 2013 11:13:23 +1000
Subject: [PATCH] Kconfig: Remove hotplug enable hints in CONFIG_KEXEC
 help texts
In-Reply-To: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
References: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20130821111323.1325e3f37faf2f54f3549832@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tue, 20 Aug 2013 21:38:03 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> commit 40b313608ad4ea655addd2ec6cdd106477ae8e15 ("Finally eradicate
> CONFIG_HOTPLUG") removed remaining references to CONFIG_HOTPLUG, but missed
> a few plain English references in the CONFIG_KEXEC help texts.
> 
> Remove them, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks good to me.  Thanks.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130821/e4e9a6da/attachment-0001.sig>
