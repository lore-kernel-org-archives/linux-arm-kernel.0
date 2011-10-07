From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 11:57:34 +0200
Subject: [PATCH 11/26] ARM: pxa: allow building palm27x without pxafb
In-Reply-To: <CAMPhdO_bKPxEEmBzSKvgYooG5YwweSYJVMdCxwYtQKJMyiWggg@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-12-git-send-email-arnd@arndb.de>
	<CAMPhdO_bKPxEEmBzSKvgYooG5YwweSYJVMdCxwYtQKJMyiWggg@mail.gmail.com>
Message-ID: <201110071157.34222.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 October 2011, Eric Miao wrote:
> Marek and I actually came up with a patch to fix this as below, this
> way to cover the declarations of those modes in the CONFIG_FB_PXA
> as well.
> 
> commit e227e88ae46e921f608b056e27e1d8704b7d12fa
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Sun Sep 11 16:56:58 2011 +0800
> 
>     ARM: pxa: fix building error by palm27x_lcd_init() when FB_PXA not defined
> 
>     Cc: Marek Vasut <marek.vasut@gmail.com>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

Yes, that looks better than my solution

	Arnd
