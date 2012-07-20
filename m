From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jul 2012 17:02:38 +0000
Subject: [PATCH v9] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <5009695D.6030005@codethink.co.uk>
References: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201207101401.30607.arnd@arndb.de> <5009695D.6030005@codethink.co.uk>
Message-ID: <201207201702.38604.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 July 2012, Ian Molton wrote:
> On 10/07/12 15:01, Arnd Bergmann wrote:
> 
> > I've pulled it now, but I would  generally prefer if you use "git
>  > request-pull" to generate the pull request, and use a signed tag as
>  > the reference so you can include the series description in the tag.
> 
> Arnd: Are you the go-to guy for all this stuff?
> 
> I just got SATA working on my ArmadaXP here, and I'd like to send
> patches.
> 
> I'd like to rebase against whatever tree is taking this stuff upstream :)
> 
> Who is working on what on these boards?
> 
> I'm working on ethernet support for the 370/XP now.

Best go through the maintainers: Andrew Lunn and Gregory Clement. They
can pick up any patches you have and forward them to me and Olof. I usually
don't take individual patches for subarchitectures that have someone
responsible for them as a primary maintainer.

	Arnd
