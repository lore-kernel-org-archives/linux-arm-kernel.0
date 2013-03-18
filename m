From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 15:58:59 +0000
Subject: [PATCH v2 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <20130318162411.11c9e3ab@skate>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303181459.10954.arnd@arndb.de> <20130318162411.11c9e3ab@skate>
Message-ID: <201303181558.59608.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Thomas Petazzoni wrote:
> So even the DT-only sub-architecture (such as mvebu) should hard-code
> the register base addresses?
> 
> The proposed DT binding in the current patch is very minimal, and I
> don't see why the more elaborate DT binding that you proposed could not
> be implemented as an improvement of it: the DT binding you proposed
> seems backward compatible with the one currently implemented, no?

It's quite possible that it could be done in a backward compatible
way, I just like to be on the safe side in case it's not.

> Anyway, whatever your decision is, I can submit an updated patch set
> that implements this, and also fix the mv78xx0 patch (my colleague
> Gregory Clement found a problem with the mv78xx0 when testing on real
> hardware).

Ok, please do that. I already pulled the first set of patches from
"[GIT PULL 1/3] ARM: mvebu: cleanup for v3.10", so make sure you
don't rebase anything that is already part of 3e762c86b337f.

	Arnd
