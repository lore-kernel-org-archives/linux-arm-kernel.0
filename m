From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Feb 2013 09:37:02 +0000
Subject: [PATCH v3] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20130213095025.079fdd89@skate>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302121812.11566.arnd@arndb.de> <20130213095025.079fdd89@skate>
Message-ID: <201302130937.02266.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, Thomas Petazzoni wrote:
> On Tue, 12 Feb 2013 18:12:11 +0000, Arnd Bergmann wrote:
> 
> > You can add my 'Reviewed-by' tag on all paches except 5, 6, and 24.
> > 
> > I'm fine with adding the other ones to 3.9, as well as adding
> > the binding document if you split that out from patch 24. Sorry for
> > making this so hard for you.
> 
> Is this really true that some more code can be taken for 3.9 ? It
> somewhat contradicts the statement that Olof has made on LAKML just a
> few hours ago "arm-soc: No new material from 3.9, fixes only".

Sorry, that was bad communiation between Olof and me. Olof has
been handling basically all of the pulls for this release
and his decision is final. The only part of the series that
I believe we should take is patch 7, since that is a bug fix.

	Arnd
