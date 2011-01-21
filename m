From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Jan 2011 14:47:28 +0100
Subject: cannot fetch arm git tree
In-Reply-To: <4D398C43.1000306@vollmann.ch>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch>
Message-ID: <20110121134728.GO14956@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Detlef,

On Fri, Jan 21, 2011 at 02:38:11PM +0100, Detlef Vollmann wrote:
> On 01/16/11 14:42, Russell King - ARM Linux wrote:
> >Let's say you already have a copy of my tree from a month ago, and Linus
> >has pulled some work from me into his tree, and repacked his tree into one
> >single pack file.  At the moment, the largest pack file from Linus is
> >400MB plus a 50MB index.
> >
> >You already have most of the contents of that 400MB pack file, but if
> >you're missing even _one_ object which is contained within it, git will
> >have to download the _entire_ 400MB pack file and index file to retrieve
> >it.
> I thought this has changed with "smart http" in git 1.6.6.
> Am I missing something?
Well, not all http repos offer smart http.  E.g. Russell doesn't[1],
probably because the serving machine doesn't have the power to nice
serve a repo via git:// or smart http://.

Best regards
Uwe

[1] I didn't recheck though

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
