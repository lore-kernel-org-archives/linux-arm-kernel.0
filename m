From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 10:17:58 -0700
Subject: [PATCH] pinctrl: provide documentation pointer
In-Reply-To: <1385390706-28722-1-git-send-email-linus.walleij@linaro.org>
References: <1385390706-28722-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <52938646.6030306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 07:45 AM, Linus Walleij wrote:
> The PIN_CONFIG_OUTPUT parameter is really tricky to understand
> and needs an explicit pointer to the documentation.

> diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h

>   * @PIN_CONFIG_OUTPUT: this will configure the pin in output, use argument

Well, while you're touching that...
s/in/as an/   s/, use/. Use/

> - *	1 to indicate high level, argument 0 to indicate low level.
> + *	1 to indicate high level, argument 0 to indicate low level. (Please
> + *	Documentation/pinctrl.txt, section "GPIO mode pitfalls" for a

Add "see" to the start of that line.

> + *	discussion around this parameter.)

(no need to resend to fix that, from my side at least)
