From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Sat, 20 Mar 2010 20:58:16 +0300
Subject: [PATCH 1/3] watchdog: Add support for the Freescale MXC watchdog
In-Reply-To: <20100320140625.GA30391@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 20 Mar 2010 14:06:25 +0000")
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
	<20100320140625.GA30391@n2100.arm.linux.org.uk>
Message-ID: <87fx3ux4cn.fsf@vovsem.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I have tested this on imx31, and unfortunately watchdog timeout expires
even after clock disable. I would be happy to be mistaken about this to
get rid of WATCHDOG_NOWAYOUT forced dependency for imx2, imx3 and imx5.

With best wishes,
Vladimir
