From: bjorn@kryo.se (Bjorn Andersson)
Date: Mon, 20 Apr 2015 08:49:37 -0700
Subject: [PATCH 0/3] ARM: ux500: Fix SD-card regression by using GPIO
 regulator
In-Reply-To: <1429538553-17366-1-git-send-email-ulf.hansson@linaro.org>
References: <1429538553-17366-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJAp7Oh1V7QKUtBnf-RCYyFD_RfTLOM5ir-jnr2DR3kg1xAOKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 7:02 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This patchset fixes an old stability issue for detection of SD-cards. The DT
> node for the GPIO regulator which controls the I/O voltage level towards the
> SD-card was disabled in below commit.
>
[..]
> The commit that introduced the thorough error handling is:
> 9369c97cc7ec ("mmc: mmci: Cascade EPROBE_DEFER from regulators")
>

Glad I could help :)

>
> Ulf Hansson (3):
>   ARM: ux500: Move GPIO regulator for SD-card into board DTSs
>   ARM: ux500: Enable GPIO regulator for SD-card for HREF boards
>   ARM: ux500: Enable GPIO regulator for SD-card for snowball
>

Looks good

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
