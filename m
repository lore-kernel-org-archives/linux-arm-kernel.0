From: ben@smart-cactus.org (Ben Gamari)
Date: Wed,  2 Dec 2015 22:19:15 +0100
Subject: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and 5422
Message-ID: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds cpufreq support for the Exynos 5800, 5420, and 5422
SOCs. In particular, it adds support for operating-points-v2 bindings to the
arm-big-little cpufreq driver and updates the above-mentioned SOCs' devicetrees
to take advantage of this support. There are also a couple of patches improving
the clarify of the arm-big-little implementation. It is built on a set posted
by Bartlomiej Zolnierkiewicz in April 2015.

The most signficant change from the original series is porting to the
operating-points-v2 devicetree bindings. The series has been tested by me on
and Odroid XU4 and by Javier Martinez Canillas on a Peach Pit.

Cheers,

- Ben
