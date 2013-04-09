From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 13:13:19 +0200
Subject: [GIT PULL 2/3] DaVinci DT updates for v3.10
In-Reply-To: <1365156017-12149-2-git-send-email-nsekhar@ti.com>
References: <1365156017-12149-1-git-send-email-nsekhar@ti.com>
 <1365156017-12149-2-git-send-email-nsekhar@ti.com>
Message-ID: <201304091313.19512.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Sekhar Nori wrote:
> Here are the DT updates for v3.10. This depends on the
> SoC updates from previous pull request.
> 

I've pulled both into the next/soc branch now, which is slightly wrong, but
your two branches belong conceptually together, and the order is fixed
now for 3.10 so the first dt branch comes before the soc branch. I did
not want to start a next/dt2 just for this.

	Arnd
