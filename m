From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Mar 2015 16:38:38 +0100
Subject: [PATCH v2 5/6] pinctrl: st: Show correct pin direction -- even
 when in GPIO mode
In-Reply-To: <1426699279-9258-6-git-send-email-lee.jones@linaro.org>
References: <1426699279-9258-1-git-send-email-lee.jones@linaro.org>
 <1426699279-9258-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdai4Gtif9vUwGW0xc9qpgkf3O4r0Lmm2aJfeL78h0P=rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 6:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Until now ST's pinconf_dbg_show() call-back has displayed the PIO
> alternate function direction, which is only relevant if a pin is
> operating in an alternate function mode i.e not GPIO mode.  If a
> pin is in GPIO mode its direction is both set and status is
> obtained by a completely different/unrelated bunch of registers.
>
> This change ensures that the correct pin direction is shown, even
> if a pin is operating in GPIO mode.
>
> Reported-by: Olivier Clergeaud <olivier.clergeaud@st.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Yours,
Linus Walleij
