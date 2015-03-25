From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Mar 2015 16:36:31 +0100
Subject: [PATCH v2 3/6] pinctrl: st: Move st_get_pio_control() further up
 the source file
In-Reply-To: <1426699279-9258-4-git-send-email-lee.jones@linaro.org>
References: <1426699279-9258-1-git-send-email-lee.jones@linaro.org>
 <1426699279-9258-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYOOQBmdJ0XFj_P4FX3wh+Civ8N9dcbNfz2BSWUEg9NRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 6:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> st_get_pio_control() will be used by subsequent calls which are
> to be located above its original position.  This is required to
> prevent the need for an unnecessary forward-declaration/prototype.
>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Yours,
Linus Walleij
