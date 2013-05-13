From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 16:20:56 -0400
Subject: [PATCH] ARM: dove: add si5351 clock driver to CuBox DT
In-Reply-To: <1367342675-15312-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367342675-15312-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130513202056.GC31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 07:24:35PM +0200, Sebastian Hesselbarth wrote:
> This patch adds the device tree node for si5351 clock generator
> and the corresponding oscillator connected to it. It also limits
> i2c frequency to 100kHz as there are bus locks reported on higher
> frequencies.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove-cubox.dts |   51 +++++++++++++++++++++++++++++++++++++-
>  1 files changed, 50 insertions(+), 1 deletions(-)

Applied to mvebu/dt

thx,

Jason.
