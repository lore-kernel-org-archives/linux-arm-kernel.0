From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 16:00:02 -0400
Subject: [PATCH] pinctrl: dove: add PMU functions to pinctrl
In-Reply-To: <1367883368-27889-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367883368-27889-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130513200002.GY31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 01:36:08AM +0200, Sebastian Hesselbarth wrote:
> Dove power management unit can mux some special functions to mpp0-15.
> This patch adds support to set/get the current PMU function mapped
> to the corresponding mpp pins. The device tree documentation is also
> updated accordingly.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  .../bindings/pinctrl/marvell,dove-pinctrl.txt      |   49 ++--
>  drivers/pinctrl/mvebu/pinctrl-dove.c               |  244 +++++++++++++++++---
>  2 files changed, 249 insertions(+), 44 deletions(-)

Sebastian,

Do you intend to have anything depending on these changes in this merge
window?

thx,

Jason.
