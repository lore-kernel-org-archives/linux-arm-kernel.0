From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 25 Jan 2012 14:48:08 +0200
Subject: [PATCH v4 - resend 10/13] ASoC: omap-abe-twl6040: Configure card
 according to platform data
In-Reply-To: <20120125113341.GB3687@opensource.wolfsonmicro.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com>
 <20120124130008.GC31839@opensource.wolfsonmicro.com>
 <4F1FBBE5.5080804@ti.com> <20120125113341.GB3687@opensource.wolfsonmicro.com>
Message-ID: <4F1FFA08.1030505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2012 01:33 PM, Mark Brown wrote:
> It'd do the right thing if you changed the code to only register the
> board widgets and routes as required - from your reply to Jassi it looks
> like you ought to do conditional reigstration anyway as the input paths
> move around between board variations.

I'm planning to do similar thing as an increment on top of this series.
Most likely the DT support will have conditional registration or - like
Tegra does - we will receive the map from DT. Not sure yet which way it
is going to be. The Tegra implementation is already there, so I might
just follow it.
At the end I want to have some consistency between the resulting sound
cards (w/ DT, w/o DT).

-- 
P?ter
