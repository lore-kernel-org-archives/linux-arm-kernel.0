From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 11 Mar 2017 21:41:36 +0100
Subject: [PATCH 1/2] clocksource: orion: read clock rate once
In-Reply-To: <E1cml2D-0007CJ-Iv@rmk-PC.armlinux.org.uk>
References: <E1cml2D-0007CJ-Iv@rmk-PC.armlinux.org.uk>
Message-ID: <20170311204136.GA1753@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 05:42:29PM +0000, Russell King wrote:
> Rather than reading the clock rate three times, read it once - we are
> about to add a fourth usage.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---

Both applied for 4.12.

Thanks!

 -- Daniel
