From: olof@lixom.net (Olof Johansson)
Date: Tue, 16 Apr 2013 09:35:26 -0700
Subject: [PATCH v6 2/3] ARM: dts: Add i2c-arbitrator bus for
 exynos5250-snow
In-Reply-To: <1366129742-16048-2-git-send-email-dianders@chromium.org>
References: <1365543270-10736-1-git-send-email-dianders@chromium.org>
 <1366129742-16048-1-git-send-email-dianders@chromium.org>
 <1366129742-16048-2-git-send-email-dianders@chromium.org>
Message-ID: <20130416163526.GB4918@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 09:29:01AM -0700, Doug Anderson wrote:
> We need to use the i2c-arbitrator to talk to any of the devices on i2c
> bus 4 on exynos5250-snow so that we don't confuse the embedded
> controller (EC).  Add the i2c-arbitrator to the device tree.  As we
> add future devices (keyboard, sbs, tps65090) we'll add them on top of
> this.
> 
> The arbitrated bus is numbered 104 simply as a convenience to make it
> easier for people poking around to guess that it might have something
> to do with the physical bus 4.
> 
> The addition is split between the cros5250-common and the snow device
> tree file since not all cros5250-class devices use arbitration.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
