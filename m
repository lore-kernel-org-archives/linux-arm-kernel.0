From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Dec 2014 22:15:43 +0800
Subject: [PATCH] ARM: dts: vf610: enable watchdog for Cortex-A5 dt's
In-Reply-To: <1417131336-3136-1-git-send-email-stefan@agner.ch>
References: <1417131336-3136-1-git-send-email-stefan@agner.ch>
Message-ID: <20141202141542.GL2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 12:35:36AM +0100, Stefan Agner wrote:
> During restructuring of the device tree files the watchdog was
> changed to be disabled by default. However, since the watchdog
> instance is dedicated to the Cortex-A5, enable the peripheral
> by default in the base device tree vf500.dtsi.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks. 
