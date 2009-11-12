From: niej0001@gmail.com (Jun Nie)
Date: Thu, 12 Nov 2009 10:17:47 +0800
Subject: [PATCH 4/8] pxa: delete redundant vsync/hsync revert flag
In-Reply-To: <7c34ac520911100012x3dfa948bn3e5106fc4c7c04f9@mail.gmail.com>
References: <7c34ac520911100012x3dfa948bn3e5106fc4c7c04f9@mail.gmail.com>
Message-ID: <7c34ac520911111817v169c88e1oea50457264490447@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From f0ba46eda943db08e60bcfe536f876f09165a64c Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 15:11:36 +0800
> Subject: [PATCH] pxa: delete redundant ?vsync/hsync revert flag
> ? ? ?var.sync can cover its function
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?include/video/pxa168fb.h | ? ?2 --
> ?1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
> index 024767c..efbe469 100644
> --- a/include/video/pxa168fb.h
> +++ b/include/video/pxa168fb.h
> @@ -142,8 +142,6 @@ struct pxa168fb_mach_info {
> ? ? ? ?unsigned ? ? ? ?invert_composite_blank:1;
> ? ? ? ?unsigned ? ? ? ?invert_pix_val_ena:1;
> ? ? ? ?unsigned ? ? ? ?invert_pixclock:1;
> - ? ? ? unsigned ? ? ? ?invert_vsync:1;
> - ? ? ? unsigned ? ? ? ?invert_hsync:1;
> ? ? ? ?unsigned ? ? ? ?panel_rbswap:1;
> ? ? ? ?unsigned ? ? ? ?active:1;
> ? ? ? ?unsigned ? ? ? ?enable_lcd:1;
> --
> 1.5.4.3
>
patch attached.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-pxa-delete-redundant-vsync-hsync-revert-flag.patch
Type: text/x-diff
Size: 822 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091112/65bf3ba5/attachment.bin>
