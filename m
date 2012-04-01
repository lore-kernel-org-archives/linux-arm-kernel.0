From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Apr 2012 14:02:16 +0100
Subject: [PATCH 1/2] clk: Fix comment for end of CONFIG_COMMON_CLK section
In-Reply-To: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120401130216.GA24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 12:32:39PM +0100, Mark Brown wrote:
> There is no else block so the #endif is for the end of the section for
> CONFIG_COMMON_CLK.

Get rid of the comment entirely.  For just a single level of ifdef it
makes no sense.
