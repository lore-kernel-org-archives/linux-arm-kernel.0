From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Mar 2017 17:33:52 -0700
Subject: [GIT PULL v2] Reset controller changes for v4.12
In-Reply-To: <1489589535.2528.23.camel@pengutronix.de>
References: <1489589535.2528.23.camel@pengutronix.de>
Message-ID: <20170322003352.GF5129@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 03:52:15PM +0100, Philipp Zabel wrote:
> Hi,
> 
> Please consider merging this tag, which adds new drivers for i.MX7 and
> Arria10, removes module code from non-modular drivers, and fixes a build
> warning in the uniphier driver and the nr_resets property usage of the
> socfpga driver as well as 64-bit compilation of the sunxi driver.
> 
> I have dropped the mfd dt-bindings patch "dt-bindings: mfd: Add Altera
> Arria10 SR Reset Controller bindings" since v1, and added "reset: sunxi:
> fix for 64-bit compilation".
> 
> regards
> Philipp
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.12-1
> 
> for you to fetch changes up to 11282a49b735ad7f4cea187de2b8dc5489343e4b:
> 
>   reset: sunxi: fix for 64-bit compilation (2017-03-15 12:19:12 +0100)

Merged, thanks!


-Olof
