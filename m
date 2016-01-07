From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Jan 2016 06:30:25 +0100
Subject: [PATCH] ARM: nomadik: set latencies to 8 cycles
In-Reply-To: <1451870308-19245-1-git-send-email-linus.walleij@linaro.org>
References: <1451870308-19245-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160107053025.GF26875@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 02:18:28AM +0100, Linus Walleij wrote:
> The Nomadik has sporadic crashes because of these latencies, setting
> them to max makes the platform work nicely, so use this values for
> now.
> 
> These latencies were set to 2 since the Nomadik platform was merged,
> but I suspect they never took effect until the right size and
> associativity for the cache was specified in the device tree and
> that is why the crash comes now.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for fixes at your
> convenience.

Applied to fixes. THanks.


-Olof
