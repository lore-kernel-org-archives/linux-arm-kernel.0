From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Feb 2013 23:17:51 +0100
Subject: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
In-Reply-To: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
References: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdbm2=+U7k=L61vwT8pZyox41N-cSBL7qj+6Byrh+8+V2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 9:53 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that we have OF based init with CLKSRC_OF, convert smp_twd init
> function to use it and covert all callers of
> twd_local_timer_of_register.

This is one good looking patch.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
