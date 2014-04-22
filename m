From: javi.merino@arm.com (Javi Merino)
Date: Tue, 22 Apr 2014 14:45:54 +0100
Subject: [PATCH v2] ARM: dts: disable MDMA1 node for Exynos5420
In-Reply-To: <000a01cf5e2b$87601760$96204620$%jun@samsung.com>
References: <000a01cf5e2b$87601760$96204620$%jun@samsung.com>
Message-ID: <20140422134554.GA6991@e102654-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 02:05:26PM +0100, Seungwon Jeon wrote:
> This change places MDMA1 in disabled node for Exynos5420.
> If MDMA1 region is configured with secure mode, it makes
> the boot failure with the following on smdk5420 board.
> ("Unhandled fault: imprecise external abort (0x1406) at 0x00000000")
> Thus, arndale-octa board don't need to do the same thing anymore.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

I've had some problem applying it (wrong EOL?).  Not sure if it's my
email client.  In any case, I've manually fixed the rejects and tested
it in my Arndale Octa.  It works for me so

Tested-by: Javi Merino <javi.merino@arm.com>
