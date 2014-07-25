From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 25 Jul 2014 18:35:43 +0200
Subject: [PATCH v2 3/4] ARM: dts: exynos5250: Fold common ChromeOS parts
 into Snow
In-Reply-To: <1405704009-8430-4-git-send-email-afaerber@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-4-git-send-email-afaerber@suse.de>
Message-ID: <CABxcv=kP2PCcNCtM1WUXx5wGG4m-jdw-P1dw0boaSwdJpoX=jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On Fri, Jul 18, 2014 at 7:20 PM, Andreas F?rber <afaerber@suse.de> wrote:
>
> +       memory {
> +               reg = <0x40000000 0x80000000>;
> +       };
> +
> +       chosen {
> +       };
> +

Is there a reason for an empty chosen node? Same for the Spring DTS.

Best regards,
Javier
