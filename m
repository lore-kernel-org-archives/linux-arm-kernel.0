From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 19:32:48 +0100
Subject: [PATCH 0/2] ARM: sunxi: Fix interrupt trigger types in the DT
In-Reply-To: <20131210180220.GB3651@lukather>
References: <1386416313-703-1-git-send-email-maxime.ripard@free-electrons.com>
 <201312071324.42353.arnd@arndb.de> <20131210180220.GB3651@lukather>
Message-ID: <201312101932.48915.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, Maxime Ripard wrote:
> On Sat, Dec 07, 2013 at 01:24:42PM +0100, Arnd Bergmann wrote:
> > On Saturday 07 December 2013, Maxime Ripard wrote:
> > > It would be great if you could merge these two patches by the end of the 3.13
> > > release cycle.
> > 
> > I guess they should be marked for 'stable' backports as well, right?
> 
> Aah, right.
> 
> I'll resend those patches Cc'ing stable.

Ok, just to clarify: there is actually no need to Cc stable in the
submission, we just need to make sure the Cc: stable is in the
changeset description as it gets merged.

	Arnd
