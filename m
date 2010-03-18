From: mike@compulab.co.il (mike at compulab.co.il)
Date: Thu, 18 Mar 2010 22:41:07 +0200
Subject: [RFC/PATCH 09/10] [ARM] tegra: harmony: Add harmony board file
In-Reply-To: <4344f3c71003171927l6723017kc6104276052cc30@mail.gmail.com>
References: <1268721688-27550-3-git-send-email-konkers@google.com>
	<1268721688-27550-4-git-send-email-konkers@google.com>
	<1268721688-27550-5-git-send-email-konkers@google.com>
	<1268721688-27550-6-git-send-email-konkers@google.com>
	<1268721688-27550-7-git-send-email-konkers@google.com>
	<1268721688-27550-8-git-send-email-konkers@google.com>
	<1268721688-27550-9-git-send-email-konkers@google.com>
	<1268721688-27550-10-git-send-email-konkers@google.com>
	<4BA090F8.20706@compulab.co.il>
	<4344f3c71003171927l6723017kc6104276052cc30@mail.gmail.com>
Message-ID: <20100318204055.GB28116@gentoodev.compulab.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 07:27:04PM -0700, Erik Gilling wrote:
> On Wed, Mar 17, 2010 at 1:21 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> >
> > I think that both panel definition and pinmux can be in the board-harmony.c
> > and thus the board-harmony.h is not needed.
> 
> In our experience board files get sufficiently cluttered with platform
> device definitions, callbacks, and fixups that splitting them apart
> make them much easer to deal with.  See the sholes support at
> http://android.git.kernel.org/?p=kernel/omap.git;a=tree;f=arch/arm/mach-omap2;hb=android-omap-2.6.32
> .

I'm not sure that staring over with several small files for different
board features is that necessary. If the board file becomes bloated than
it'd make sense to split it. But a board file with three platform device
definitions and mux table is not that big...

> -Erik

--
Sincerely yours,
Mike.
