From: saaguirre@ti.com (Aguirre, Sergio)
Date: Tue, 4 May 2010 08:10:13 -0500
Subject: [PATCH v3] arm: Fix .gitignore for boot/compressed folder
In-Reply-To: <20100503195855.GA18647@n2100.arm.linux.org.uk>
References: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
	<20100503195855.GA18647@n2100.arm.linux.org.uk>
Message-ID: <A24693684029E5489D1D202277BE8944551B97F3@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
Sent: Monday, May 03, 2010 2:59 PM
> On Mon, May 03, 2010 at 02:51:25PM -0500, Sergio Aguirre wrote:
> > This should complement changes done in:
> >
> >   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
> >   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
> >   Date:   Fri Jan 8 14:42:43 2010 -0800
> >
> >       arm: add support for LZO-compressed kernels
> >
> > It missed to do the respective changes in '.gitignore' file.
> >
> > Also, add vmlinux to the list, which is generated also during
> > the build.
> >
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Ok.

Thanks!

Regards,
Sergio
