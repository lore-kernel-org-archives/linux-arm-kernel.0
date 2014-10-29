From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 29 Oct 2014 22:39:42 +0400
Subject: [PATCH] ARM: pxa: tosa: switch to gpio-charger
In-Reply-To: <1414170862-17995-1-git-send-email-dbaryshkov@gmail.com>
References: <1414170862-17995-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CALT56yNZ+S29LHK8Hh5zM_YRmH4My69Kao7CsCpm4BRitpWDmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-24 20:14 GMT+03:00 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>:
> Switch to simpler gpio-charger module. PDA power requires additional
> setup in platform file and is more suited for boards with separate AC
> and USB charging inputs. Tosa has a unified input, so it's better suited
> for gpio-charger.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-pxa/tosa.c | 41 +++++++----------------------------------
>  1 file changed, 7 insertions(+), 34 deletions(-)

ping


-- 
With best wishes
Dmitry
