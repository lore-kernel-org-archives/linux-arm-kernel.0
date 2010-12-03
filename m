From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 17:10:00 -0800
Subject: [PATCH v3] arm: mach-omap2: remove NULL board_mux from board files
In-Reply-To: <1291296340-27327-1-git-send-email-aaro.koskinen@nokia.com>
References: <1291296340-27327-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <20101203011000.GB17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [101202 05:15]:
> If CONFIG_OMAP_MUX is not enabled, we can define board_mux in the header
> file instead of forcing every single board to define it.

Thanks, queueing for the next merge window.

Tony
