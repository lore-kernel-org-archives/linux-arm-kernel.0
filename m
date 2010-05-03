From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 May 2010 20:58:55 +0100
Subject: [PATCH v3] arm: Fix .gitignore for boot/compressed folder
In-Reply-To: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
References: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
Message-ID: <20100503195855.GA18647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 03, 2010 at 02:51:25PM -0500, Sergio Aguirre wrote:
> This should complement changes done in:
> 
>   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
>   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
>   Date:   Fri Jan 8 14:42:43 2010 -0800
> 
>       arm: add support for LZO-compressed kernels
> 
> It missed to do the respective changes in '.gitignore' file.
> 
> Also, add vmlinux to the list, which is generated also during
> the build.
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Ok.
