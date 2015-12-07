From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Mon, 7 Dec 2015 13:25:10 +0000
Subject: [PATCH v5 4/4] MAINTAINERS: Add Liviu Dudau as maintainer for ARM
 HDLCD driver.
In-Reply-To: <1449490265-6752-5-git-send-email-Liviu.Dudau@arm.com>
References: <1449490265-6752-1-git-send-email-Liviu.Dudau@arm.com>
 <1449490265-6752-5-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CACvgo537fFQJYA6vh1pnq+6GwdNC=cSnumar4kWHeFQpRqaBbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 December 2015 at 12:11, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> Update MAINTAINERS file for HDLCD driver.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Jiri Slaby <jslaby@suse.com>
>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba790b..8a637e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -820,6 +820,12 @@ S: Maintained
>  F:     drivers/net/arcnet/
>  F:     include/uapi/linux/if_arcnet.h
>
> +ARM HDLCD DRM DRIVER
> +M:     Liviu Dudau <liviu.dudau@arm.com>
> +S:     Maintained
You surely meant Supported, didn't you ?

Regards,
Emil
