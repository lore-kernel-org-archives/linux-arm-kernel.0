From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 12 Jan 2015 10:20:49 -0800
Subject: [PATCH] pinctrl: pinconf-generic: loose DT dependence
In-Reply-To: <1421020166-22831-1-git-send-email-linus.walleij@linaro.org>
References: <1421020166-22831-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <52c662b797754a37966532ef95304610@BL2FFO11FD050.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-12 at 12:49AM +0100, Linus Walleij wrote:
> New pin controllers such as ACPI-based may also have custom properties
> to parse, and should be able to use generic pin config. Let's make the
> code compile on !OF systems and rename members a bit to underscore it
> is custom parameters and not necessarily DT parameters.
> 
> This fixes a build regression for x86_64 on the zeroday kernel builds.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-and-tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
