From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 10:19:26 +0200
Subject: [PATCH] pinctrl: single: use of_device_get_match_data() to get
 soc data
In-Reply-To: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdaM_p7QUq8afD03tCkWExZn9y8MXP5BDPXbV_atofTvsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 20, 2017 at 6:02 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Use of_device_get_match_data() instead of of_match_device().
> It allows us to remove the forward declaration of pcs_of_match.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
