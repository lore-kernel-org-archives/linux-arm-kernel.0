From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Sep 2014 23:15:43 +0800
Subject: [PATCHv6 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <1410808436-21460-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410808436-21460-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410808436-21460-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CAGb2v65QpcukxAyQuxbhgqCk4RNj8PgMF1dic1=9FexTa2zcvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 16, 2014 at 3:13 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> This adds a generic PWM framework driver for the PWM controller
> found on Allwinner SoCs.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pwm/Kconfig     |   9 ++
>  drivers/pwm/Makefile    |   1 +

This patch doesn't apply on either linux-pwm/for-next or sunxi-next.
The above files conflict with "pwm: sti: Add new driver for ST's PWM IP".
Respinning on either tree should work, as both trees have that commit.

>  drivers/pwm/pwm-sunxi.c | 371 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 381 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sunxi.c

[...]

Thanks

ChenYu
