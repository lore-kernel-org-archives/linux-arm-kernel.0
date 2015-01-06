From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 06 Jan 2015 01:04:47 +0100
Subject: [PATCH] arm: pxa: fix pxa27x device-tree support kconfig
In-Reply-To: <87a933yuzo.fsf@free.fr>
References: <1417206768-5840-1-git-send-email-robert.jarzmik@free.fr>
 <87a933yuzo.fsf@free.fr>
Message-ID: <1420502687.14308.54.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Thu, 2014-12-04 at 22:18 +0100, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > Remove the useless CPU_PXA27x non existing kconfig option.
> > The true options is PXA27x, which is already selected.
> >
> > Reported-by: Paul Bolle <pebolle@tiscali.nl>
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Queued to pxa/for-next.

This patch is not urgent, of course, but by now I would have expected it
to hit linux-next. So I decided to send out this reminder.


Paul Bolle
