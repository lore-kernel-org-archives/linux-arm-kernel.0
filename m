From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 18:14:09 +0000
Subject: [PATCH v2 02/14] clocksource: sp804: add device tree support
In-Reply-To: <1363108124-17484-3-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303121814.09838.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Haojian Zhuang wrote:
> Parse clock & irq from device tree for sp804.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/clocksource/timer-sp.c |  105 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 


The patch looks ok to me, but it need  a binding document in 
Documentation/devicetree/bindings/

	Arnd
