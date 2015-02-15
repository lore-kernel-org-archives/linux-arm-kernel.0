From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Sun, 15 Feb 2015 01:25:59 +0100
Subject: [PATCHv3 0/8] devfreq: Add generic exynos memory-bus
 frequency driver
In-Reply-To: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <54DFE797.1020008@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've tested the series on my Odroid-X2 (by adapting the TRATS2 changes),
and so far I haven't seen any issues. With the system being idle one can
see that the 'simple_ondemand' devfreq governor clocks down both memory
busses to the lowest state.

With best wishes,
Tobias
