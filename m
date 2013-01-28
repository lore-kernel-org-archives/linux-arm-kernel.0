From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jan 2013 14:59:17 -0800
Subject: [PATCH 1/5] pinctrl/abx500: add AB8500 sub-driver
In-Reply-To: <1359380995-27950-1-git-send-email-linus.walleij@stericsson.com>
References: <1359380995-27950-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130128225917.GD7789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 02:49:55PM +0100, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This adds a subdriver for the AB8500 pinctrl portions.
> As the pin controller (also the ABx500 controllers) is an
> inherent part of the SoC and will prevent boot if not
> available, select this from the Ux500 SoC Kconfig.
> 
> Cc: arm at kernel.org
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Requesting an ACK from the ARM SoC maintainers for this patch.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
