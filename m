From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 11:00:53 +0100
Subject: [PATCH 2/4] pinctrl: mvebu: Fix dove_audio1_ctrl_set function
In-Reply-To: <1353317996-20841-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353317996-20841-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZy86OAYbszTZDrs+bdkkEmS9+8z450U1qX+AF4sp5C5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 10:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> From: Axel Lin <axel.lin@ingics.com>
>
> When setting audio1 pinmux the bits in the corresponding registers
> are not cleared. This fix first clears all bits and then sets the
> required bits according to the selected function.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
