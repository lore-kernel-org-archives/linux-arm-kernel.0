From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 22:54:13 +0200
Subject: [PATCH 02/26] clk: nomadik: move src init out of nomadik_clk_init
In-Reply-To: <1379526839-14798-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdaD9yvtxP8a6gav_KaYWYSO_uh_e6Qz2bM8-0jTpvJ9gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 7:53 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> nomadik_clk_init currently also maps system reset controller base address
> used by clocks and registers a reboot notifier. To allow further cleanup of
> nomadik clk setup, this moves system reset controller setup from
> nomadik_clk_init to its own function.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

I don't see where it's going until I've seen the rest of the patches
but OK: Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
