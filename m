From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Feb 2015 00:08:52 -0800
Subject: [GIT PULL] ARM: rockchip: third (and last) batch of dts updates
 for 3.20
In-Reply-To: <1557277.LNNjscMhd1@diego>
References: <1557277.LNNjscMhd1@diego>
Message-ID: <20150206080852.GC23582@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 09:39:28PM +0100, Heiko St?bner wrote:
> Hi Arnd, Olof,
> 
> if it is not to late, I have accumulated some more dts changes during the
> last days.
> 
> The most interesting change is probably enabling the display nodes on
> both the rk3288-firefly and rk3288-evb. I was sucessfully able to reach a
> framebuffer console on both boards using the hdmi output.
> 
> To reach an actual X-session, a further patch to the drm driver is
> necessary [0], but still the general framebuffer output is working
> nonetheless.
> 
> 
> Second most interesting change is the addition of cpu and gpu regulators
> to the act8846 variant of the evb which I was able to realize and test with
> the help of Daniel Lezcano yesterday.
> 
> 
> And finally adding a clock node to the rk3288 watchdog, as the dw_wdt
> driver needs to read the actual clock rate at times. This brings with it a
> stable shared branch with the clock tree to hold the new dt clock ids,
> which Mike merged into the clock-tree half an hour after I send the
> second pull request some days ago.
> 
> 
> So if it's not to late, please pull

This seems reasonably self-contained and doesn't seem to be high risk. Merged
in now even though it's a bit close to the merge window.


-Olof
