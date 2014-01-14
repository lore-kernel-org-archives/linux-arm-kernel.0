From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 10:34:38 -0800
Subject: [PATCH] ARM: at91: smc: bug fix in sam9_smc_cs_read()
In-Reply-To: <1389279714-30873-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Thu, 9 Jan 2014 16:01:54 +0100")
References: <1389279714-30873-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <87fvoq8la9.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>
> There was a copy/paste error when reading the nwe_pulse value.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Acked-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Cc: stable <stable@vger.kernel.org> # 3.3
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Arnd, Olof, Kevin,
>
> This is a little fix that I have just received. As the "fixes" colletion is
> certainly closed for 3.13, I would like to include this one in the
> "fixes-non-critical" topic for 3.14.
>
> For the time being, I only have this one, so It can be convenient if you take
> this fix as a patch instead of a pull-request.

Applied to fixes-non-critical, and merged into for-next.

Thanks,

Kevin
