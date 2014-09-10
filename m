From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 10 Sep 2014 22:46:07 +0200
Subject: [PATCH 1/3] ASoC: tegra: add tegra sgtl5000 machine driver
In-Reply-To: <CAOMZO5BYGwHGSeHeaQxEO=BUBGbno9P29et582SDzmwmfVioZA@mail.gmail.com>
References: <cover.1410276224.git.marcel@ziswiler.com>
 <f90791ebb1799a4aa62dd6b527885ddadae3c058.1410276224.git.marcel@ziswiler.com>
 <CAOMZO5BYGwHGSeHeaQxEO=BUBGbno9P29et582SDzmwmfVioZA@mail.gmail.com>
Message-ID: <1410381967.16012.8.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-09 at 15:00 -0300, Fabio Estevam wrote:
> What about using the simple-audio-card binding instead of adding the
> tegra_sgtl5000 machine driver?

Good question. I have to admit last I checked on the current state of
affairs on vybrid towards end of last year none of this existed yet.
Sweet. Will try and resubmit v2 with that in mind.

> An example of simple-audio-card used with sgtl5000 can be found here:
> 
> http://www.spinics.net/lists/devicetree/msg44466.html

While above linked example does not quite look like a proper example
thereof I do get the point. Please excuse my ignorance.
