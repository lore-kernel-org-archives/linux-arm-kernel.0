From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 23 Nov 2012 16:54:09 +0100
Subject: [PATCH 0/2] Input: nomadik-ske-keypad - clk fixups
In-Reply-To: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CAPDyKFq+MBo2338SiAF-mdDHpgTDJ0p6k2BaicJpSutGqtaubA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 November 2012 15:20, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Due to the convert to the common clk driver these changes for clks are needed.
>
> Ulf Hansson (2):
>   Input: nomadik-ske-keypad - fixup use of clk
>   Input: nomadik-ske-keypad - start using the apb_pclk
>
>  drivers/input/keyboard/nomadik-ske-keypad.c |   34 +++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> --
> 1.7.10
>

Just a kind reminder here. Do we see any issues with merging this?

Kind regards
Ulf Hansson
