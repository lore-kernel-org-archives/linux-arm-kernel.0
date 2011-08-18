From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Thu, 18 Aug 2011 11:10:03 +0530
Subject: [PATCH] ARM: mmp: rename SHEEVAD to GPLUGD
In-Reply-To: <1313469117-7818-1-git-send-email-eric.y.miao@gmail.com>
References: <1313469117-7818-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <4E4CA5B3.3030706@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 16 August 2011 10:01 AM, Eric Miao wrote:
> GuruPlugD was initially named to be SHEEVAD, and it's causing naming
> confusion in the mach-types database. Make it consistent by renaming
> to GPLUGD.
>
> Signed-off-by: Eric Miao<eric.y.miao@gmail.com>
Acked-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
>   arch/arm/mach-mmp/Kconfig  |    2 +-
>   arch/arm/mach-mmp/Makefile |    2 +-
>   arch/arm/mach-mmp/gplugd.c |    2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
