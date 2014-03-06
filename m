From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 15:18:03 -0500
Subject: [PATCH 3/3] pinctrl: mvebu: silence WARN to dev_warn
In-Reply-To: <1393977790-29110-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393977790-29110-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140306201803.GL1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 01:03:10AM +0100, Sebastian Hesselbarth wrote:
> Pinctrl will WARN on missing DT resources, which is a little bit too
> noisy. Use dev_warn with FW_BUG instead.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk> 
> Cc: Jason Cooper <jason@lakedaemon.net> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: devicetree at vger.kernel.org 
> Cc: linux-arm-kernel at lists.infradead.org 
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/pinctrl/mvebu/pinctrl-dove.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to mvebu/pinctrl

thx,

Jason.
