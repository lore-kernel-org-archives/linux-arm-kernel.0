From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:30:45 +0100
Subject: [PATCH v5 5/8] pinctrl: Cygnus: define Broadcom Cygnus
 GPIO/PINCONF binding
In-Reply-To: <1425515756-321-6-git-send-email-rjui@broadcom.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-6-git-send-email-rjui@broadcom.com>
Message-ID: <CACRpkdYy75-fH29W-pr5ExuQc6dfO1Xe5UtFr49GAdnVHyXuCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 5, 2015 at 1:35 AM, Ray Jui <rjui@broadcom.com> wrote:

> Document the GPIO/PINCONF device tree binding for Broadcom Cygnus SoC
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
(...)

> +- ngpios:
> +    Total number of GPIOs the controller provides

Remind me again. Why don't we know this from the compatible string?

(I paused applying the patches here waiting for the answer.)

Yours,
Linus Walleij
