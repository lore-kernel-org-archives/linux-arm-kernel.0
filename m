From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 11:15:40 +0800
Subject: [PATCH] ARM: dts: imx7: add CPU PMU support
In-Reply-To: <20180227151610.21887-1-stefan@agner.ch>
References: <20180227151610.21887-1-stefan@agner.ch>
Message-ID: <20180228031539.GF3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 04:16:10PM +0100, Stefan Agner wrote:
> Enable support for ARM Performance Monitoring Units available
> on the Cortex-A7 CPU. There is only a single interrupt for the
> PMU in both variants of the family, i.MX 7Solo and 7Dual.
> 
> Tested with perf on a i.MX 7Dual:
>   hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 counters available
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
