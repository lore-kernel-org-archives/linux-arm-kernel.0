From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 23:32 +0100
Subject: [GIT PULL 1/4] ARM: imx: soc updates for 4.6
In-Reply-To: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
References: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
Message-ID: <2391647.boUdyk2pYU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 March 2016 23:00:00 Shawn Guo wrote:
> The i.MX SoC update for 4.6:
> - Enable big endian mode support for i.MX platform
> - Add support for i.MX6QP SoC which is the latest i.MX6 family addition
> - Add basic suspend/resume support for i.MX25
> - A couple of i.MX7D support updates


Merged into next/soc, thanks!


> - A few random code cleanups

I wonder if those should have been in a separate cleanup branch. I didn't
look at the detailed changes here, so I assume you had a good reason
to put them in here.

	Arnd
