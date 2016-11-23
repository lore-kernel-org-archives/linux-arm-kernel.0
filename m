From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2016 12:43:17 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Drivers Updates
 for v4.10
In-Reply-To: <20161119013551.GB2543@localhost>
References: <cover.1479389981.git.horms+renesas@verge.net.au>
 <20161119013551.GB2543@localhost>
Message-ID: <4069888.eCuRFVJTuP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 18, 2016 5:35:51 PM CET Olof Johansson wrote:
> 
> So, this pull request contains 8 patches, not 4. Seems like your pull
> request doesn't show any of the code from Geert's branch, didn't mention
> it in the tag and only in the email text above. Furthermore, Geert's
> branch modifies driver core code, so it's extra important to make sure
> it's clear that it's an unusual pull request.
> 
> Given that this modifies driver core, please either merge that code
> through Greg first, or get an ack from him. If you merge through him,
> make sure it's on a standalone topic branch that we can share.

As discussed on IRC, I think it makes sense to track that branch
separately in arm-soc, as its own top-level next/* branch.

The branch was first merged into the mmc tree after we got consensus
on the approach.

	Arnd
