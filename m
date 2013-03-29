From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 29 Mar 2013 19:44:13 +0100
Subject: [PATCH 0/5] video: vt8500 patches for 3.10
In-Reply-To: <1364021193-19835-1-git-send-email-linux@prisktech.co.nz>
References: <1364021193-19835-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130329184413.GJ20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:46 Sat 23 Mar     , Tony Prisk wrote:
> Hi Florian,
> 
> These patches were posted for 3.9, but I didn't recieve any reply back at the
> time. Reposting for 3.10 - based on 3.9-rc2
> 
> Regards
> Tony P
look ok

Best Regards,
J.
> 
> Julia Lawall (1):
>   drivers/video/wm8505fb.c: use devm_ functions
> 
> Tony Prisk (4):
>   video: vt8500: Make wmt_ge_rops optional
>   video: vt8500: Remove unused platform_data/video-vt8500lcdfb.h
>   video: vt8500: Correct descriptions in video/Kconfig
>   video: vt8500: Adjust contrast in wm8505 framebuffer driver.
> 
>  drivers/video/Kconfig                           |   31 ++++----
>  drivers/video/vt8500lcdfb.c                     |   17 +++-
>  drivers/video/wm8505fb.c                        |   96 ++++++++---------------
>  include/linux/platform_data/video-vt8500lcdfb.h |   31 --------
>  4 files changed, 66 insertions(+), 109 deletions(-)
>  delete mode 100644 include/linux/platform_data/video-vt8500lcdfb.h
> 
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
