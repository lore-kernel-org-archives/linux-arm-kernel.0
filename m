From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 10 Sep 2014 22:52:05 +0200
Subject: [PATCH 1/3] ASoC: tegra: add tegra sgtl5000 machine driver
In-Reply-To: <541083EC.7080803@wwwdotorg.org>
References: <cover.1410276224.git.marcel@ziswiler.com>
 <f90791ebb1799a4aa62dd6b527885ddadae3c058.1410276224.git.marcel@ziswiler.com>
 <CAOMZO5BYGwHGSeHeaQxEO=BUBGbno9P29et582SDzmwmfVioZA@mail.gmail.com>
 <541083EC.7080803@wwwdotorg.org>
Message-ID: <1410382325.16012.11.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-10 at 11:01 -0600, Stephen Warren wrote:
> I don't think that will work; the Tegra audio complex requires some 
> clock management that doesn't immediately seem to fit into the 
> simple-audio-card concept.

Could you elaborate on that one? At least for our use case it seems to
work just fine. See v2 following ASAP.
