From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 23:06:18 +0000
Subject: [PATCH 2/2] ARM: pcmcia: fix checkpatch.pl issues in soc_common.c
In-Reply-To: <cecb6d8f1003261457x69c319c1w884ade1746f81e8b@mail.gmail.com>
References: <1269471898-26301-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<1269471898-26301-2-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100324230729.GA21359@n2100.arm.linux.org.uk>
	<4BAB38B1.8080404@ru.mvista.com>
	<20100326181800.GB21682@n2100.arm.linux.org.uk>
	<cecb6d8f1003261457x69c319c1w884ade1746f81e8b@mail.gmail.com>
Message-ID: <20100326230618.GD29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 06:57:07PM -0300, Marcelo Jimenez wrote:
> On Fri, Mar 26, 2010 at 15:18, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Mar 25, 2010 at 01:19:29PM +0300, Sergei Shtylyov wrote:
> >>
> >> ? I'd disagree in this case. Anybody will hardly grep for "mask:
> >> %s%s%s%s%s%sflags: %s%s%s%s%s%s".
> >
> > Well, I disagree on a matter of principle with you. ?If you want to avoid
> > the line going over 80 columns, move the entire string onto the next line.
> > Then we can have the entire string intact _and_ we can have it fitting
> > within 80 columns.
> 
> This is no big deal. Also, I have already submitted the new patch and
> Valdis had a good point for egrep.

Sorry, I'm having stability issues with my MTA which inexplicably died
about 12 hours ago, presumably due to the level of crap flying around
the 'net nowadays.  This appears to be becoming a regular occurance in
the last week. ;(
