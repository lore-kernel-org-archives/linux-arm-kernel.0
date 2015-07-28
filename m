From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 29 Jul 2015 00:28:42 +0200
Subject: [PATCH v4 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
In-Reply-To: <1437973493-26872-2-git-send-email-ariel@vanguardiasur.com.ar>
References: <1437973493-26872-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1437973493-26872-2-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <CAGhQ9VzDZhrYTkpvAWntryvg=2K-f+H=yT+Wjifssz3-7pz_bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 July 2015 at 07:04, Ariel D'Alessandro <ariel@vanguardiasur.com.ar> wrote:
> This commit adds support for the watchdog timer found in NXP LPC SoCs
> family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
> share the same watchdog hardware.
>
> Watchdog driver registers a restart handler that will restart the system
> by performing an incorrect feed after ensuring the watchdog is enabled in
> reset mode.
>
> As watchdog cannot be disabled in hardware, driver's stop routine will
> regularly send a keepalive ping using a timer.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

For the LPC18xx hardware specific parts:
Reviewed-by: Joachim Eastwood <manabian@gmail.com>

regards,
Joachim Eastwood
