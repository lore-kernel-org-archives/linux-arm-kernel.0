From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 20 May 2010 15:25:59 +0900
Subject: [PATCH 1/7] ARM: S5PV210: add support for software reset
In-Reply-To: <010101caf7e4$bd6ef490$384cddb0$%kim@samsung.com>
References: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
	<1274079195-18105-2-git-send-email-m.szyprowski@samsung.com>
	<010101caf7e4$bd6ef490$384cddb0$%kim@samsung.com>
Message-ID: <AANLkTin2tClftHdVdrlWCuLl2F1Q7WltxTxGngN_b_hB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>
> But Samsung SoC hardware engineer recommends to use the reset of watchdog
> instead of software reset by restriction of Hardware environment.

that's optional method for each board. If software reset doesn't work.
we can provide the watchdog reset additionally
.

In our case we use the watchdog reset for other purpose so we don't
want to use watchdog reset at normal reset condition.

Thank you,
Kyungmin Park
