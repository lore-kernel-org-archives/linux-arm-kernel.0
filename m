From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 06 Dec 2015 20:50:56 +0100
Subject: [GIT PULL] LPC32xx DTS changes for v4.4
In-Reply-To: <56641DCB.5080600@mleia.com>
References: <1447863700-15681-1-git-send-email-vz@mleia.com>
 <565B024A.2030704@mleia.com> <56641DCB.5080600@mleia.com>
Message-ID: <3112069.RxjfiMKgHG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 December 2015 13:36:43 Vladimir Zapolskiy wrote:
> On 29.11.2015 15:48, Vladimir Zapolskiy wrote:
> > Hi Arnd,
> > 
> > On 18.11.2015 18:21, Vladimir Zapolskiy wrote:
> >> Hi arm-soc team,
> >>
> >> Please consider pulling these DTS changes for the NXP LPC32xx
> >> platform and related boards.
> >>
> >> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> >>
> >>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>   https://github.com/vzapolskiy/linux.git lpc32xx-dts
> >>
> >> for you to fetch changes up to aa29efb445f11506daca0db934331f144b38ddc4:
> >>
> >>   arm: dts: lpc32xx: move USB controller subdevices into own device node (2015-11-18 18:01:27 +0200)
> > 
> > this is an old reviewed series, I suppose it is too late to include it
> > into v4.4, should I resend the same pull request for v4.5?
> > 
> > Or is it possible to merge it as is?
> 
> Is there anything, what prevents this changes from being merged?

I have them on my radar, this has been another time where we are slow
to start merging things. I have merged a couple of other branches, but
none of the  DT changes for any platform so far.

I've just verified that the branch still merges fine into the current
kernel, otherwise I'd ask you to resubmit it based on v4.4-rc1.
We should really get to it this time in the next few days.

	Arnd
