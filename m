From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 17:10:24 -0800
Subject: [PATCH 1/2] arm: mach-omap2: n8x0: clean up dummy onenand init
In-Reply-To: <1291305084-9159-1-git-send-email-aaro.koskinen@nokia.com>
References: <1291305084-9159-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <20101203011023.GC17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [101202 07:40]:
> When OneNAND support is disabled, the platform code defines NULL
> board_onenand_data and empty init function for us. By utilizing this we
> can avoid cluttering board files with dummy definitions/wrappers.

Applying these too.

Tony
