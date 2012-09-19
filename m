From: andreoloid@gmail.com (Domenico Andreoli)
Date: Wed, 19 Sep 2012 10:54:33 +0200
Subject: [PATCH V6] ARM: bcm2835: add stub clock driver
In-Reply-To: <1348026973-18887-1-git-send-email-swarren@wwwdotorg.org>
References: <1348026973-18887-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOREObGmF9ND9Y16HkczGf0DrUULgg-Y7KRnjof97ATcpsZpmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sep 19, 2012 5:57 AM, "Stephen Warren" <swarren@wwwdotorg.org> wrote:
> diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
> new file mode 100644
> index 0000000..ad65f0e
> --- /dev/null
> +++ b/drivers/clk/clk-bcm2835.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2010 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
 USA
> + */

why the copyright is of Broadcom? these files are written from scratch or
anyway being reworked quite a bit, right?

cheers,
Domenico
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120919/0f63a636/attachment-0001.html>
