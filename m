From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 14 Apr 2014 14:07:47 +0100
Subject: [PATCH v2 0/4] net: Add APM X-Gene SoC Ethernet driver support
In-Reply-To: <1397271984-23405-1-git-send-email-isubramanian@apm.com>
References: <1397271984-23405-1-git-send-email-isubramanian@apm.com>
Message-ID: <534BDDA3.3080005@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/14 04:06, Iyappan Subramanian wrote:
> This patch series adds support for the APM X-Gene SoC Ethernet driver.
>
> v2
> * Completely redesigned ethernet driver
> * Added support to work with big endian kernel
> * Renamed dtb phyid entry to phy_addr
> * Changed dtb local-mac-address entry to byte string format
> * Renamed dtb eth8clk entry to menetclk

Patch 2/4 seems to have vanished?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
