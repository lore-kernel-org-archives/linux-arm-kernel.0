From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Oct 2014 17:29:18 +0100
Subject: [PATCH 3/3] arm64: Add Juno SoC device tree.
In-Reply-To: <1414771460-7340-4-git-send-email-Liviu.Dudau@arm.com>
References: <1414771460-7340-1-git-send-email-Liviu.Dudau@arm.com>
 <1414771460-7340-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20141031162918.GG32139@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 04:04:20PM +0000, Liviu Dudau wrote:
> This adds support for USB, 100MB Ethernet port, timers, I2C,
> and watchdog timer. Missing for now are the SMMU nodes, HDLCD
> and PCIe.

Hi Liviu

I know nothing about Juno, but i do help maintain the Marvell SoC
device tree files.

It seems pretty normal to split device tree descriptions into a
generic .dtsi SoC part and a number of .dts board files, one per
board, and including the SoC .dtsi file.

Is it likely another board will be designed using the same SoC?

   Andrew
