From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 09 Jul 2018 14:46:07 -0700
Subject: [PATCH 0/3] ARM64: dts: meson-axg: first round of daughter card
 updates
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Thu, 28 Jun 2018 11:50:51 +0200")
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Message-ID: <7hsh4snkv4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds a speaker amplifier and some leds present on daughter
> cards which are connected to the s400 board.
>
> Kevin, please note that the bindings documentation update for the tas5707
> has been queued for next in Mark Brown's ASoC tree. Not having it won't
> break anything but you may get checkpatch warning.

Thanks for the warning.

Series applied to v4.19/dt64,

Kevin
