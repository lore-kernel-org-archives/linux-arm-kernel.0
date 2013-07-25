From: horms@verge.net.au (Simon Horman)
Date: Thu, 25 Jul 2013 22:23:34 +0900
Subject: [PATCH v2 3/3] ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in
 defconfig
In-Reply-To: <51F14216.1010606@cogentembedded.com>
References: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
 <1374718423-24230-4-git-send-email-horms+renesas@verge.net.au>
 <51F14216.1010606@cogentembedded.com>
Message-ID: <20130725132334.GD30895@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 07:19:50PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-07-2013 6:13, Simon Horman wrote:
> 
> >"ARM: shmobile: marzen: Switch to DT_MACHINE_START" moves marzen
> >over to use DT_MACHINE_START, however, the prevelant boot loader
> 
>    s/prevelant/prevalent/?

Thanks, I will fix that.

> >does not support booting with a separate dtb. Thus, it makes
> >sense to use ARM_APPENDED_DTB by default.
> 
> >This is consistent with other shmobile defconfigs.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
