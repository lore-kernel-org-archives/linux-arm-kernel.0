From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Jun 2017 18:06:06 +0200
Subject: [PATCH 07/51] rtc: ab8500: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-8-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-8-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <CACRpkdbBu2y4F2hOYmM9Wn1Y4k0R9yh1AC+4_6kqrYb6dgnnqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 11:35 AM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:

> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: rtc-linux at googlegroups.com
> CC: linux-kernel at vger.kernel.org
> CC: linux-arm-kernel at lists.infradead.org

Looks fine.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
