From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 22 Feb 2018 19:28:03 +0200
Subject: [PATCH v3 06/10] pwm: add PWM modes
In-Reply-To: <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 2:01 PM, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
> Add PWM normal and complementary modes.

> +- PWM_DTMODE_COMPLEMENTARY: PWM complementary working mode (for PWM
> +channels two outputs); if not specified, the default for PWM channel will
> +be used

What DT stands for?

-- 
With Best Regards,
Andy Shevchenko
