From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 16:07:28 -0800
Subject: [PATCH] ARM: Ux500: add synaptics RMI4 for Ux500 TVK DT
In-Reply-To: <1456130006-4169-1-git-send-email-linus.walleij@linaro.org>
References: <1456130006-4169-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160313000728.GA17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:33:26AM +0100, Linus Walleij wrote:
> This adds the Synaptics RMI4 touchscreen to the Ux500 TVK
> user interface board. Tested on the U8500 HREFv60plus with
> the TVK UIB.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC maintainers: please apply this patch directly for-next
> on some DT branch, I have no other Ux500 DT patches. These bindings
> are ACKed by Rob Herring in another thread so I think it's pointless
> to keep it out of tree.

Applied with slightly modified subject line.


-Olof
