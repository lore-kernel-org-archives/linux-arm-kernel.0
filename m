From: schwab@linux-m68k.org (Andreas Schwab)
Date: Mon, 03 Nov 2014 19:15:04 +0100
Subject: [PATCH v4 1/9] PM / Domains: Change prototype for the
 ->attach_dev() callback
In-Reply-To: <1415028896-9005-2-git-send-email-geert+renesas@glider.be> (Geert
 Uytterhoeven's message of "Mon, 3 Nov 2014 16:34:48 +0100")
References: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
 <1415028896-9005-2-git-send-email-geert+renesas@glider.be>
Message-ID: <8761ewduc7.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Convert the prototype to return and int. This is just an initial step,

s/and/an/

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
