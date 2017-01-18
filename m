From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 11:28:16 -0800
Subject: [PATCH 0/5] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 3 Dec 2016 00:47:34 +0100")
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
Message-ID: <m2a8ao1833.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This partially fixes the 1000Mbit/s ethernet TX throughput issues (on
> networks which are not affected by the EEE problem, as reported here:

Based on the discussions with Jerome, I'm dropping this series from the
v4.11/dt64 branch for now.

This series also had a small conflict with Jerome's fix[1] for the
odroid-c2, so please rebase any updates here on my v4.10/fixes branch.

Kevin

[1] https://git.kernel.org/cgit/linux/kernel/git/khilman/linux-amlogic.git/commit/?h=v4.10/fixes
