From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 10:06:54 +0200
Subject: [PATCH v2] pinctrl: stm32: factorize
 stm32_pconf_input/output_get()
In-Reply-To: <1464091063-22341-2-git-send-email-patrice.chotard@st.com>
References: <1464091063-22341-1-git-send-email-patrice.chotard@st.com>
 <1464091063-22341-2-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdY0Z7J347u1UkdYKpbKCga_JiJ+bKmULXAv2rWyb24cmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 1:57 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> As these 2 functions code are 95% similar, factorize them.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
