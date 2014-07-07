From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 17:32:24 +0200
Subject: [PATCH] pinctrl: st: add IRQCHIP_SKIP_SET_WAKE flag
In-Reply-To: <1403711344-17335-1-git-send-email-patrice.chotard@st.com>
References: <1403711344-17335-1-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdY64C0PNEK+E_AVhhxvJMXOiesFHOcvFpRpoTrfb0dtMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 5:49 PM, Patrice CHOTARD <patrice.chotard@st.com> wrote:

> From: David PARIS <david.paris@st.com>
>
> no .irq_set_wake API is available for pinctrl-st driver.
> Add the IRQCHIP_SKIP_SET_WAKE flag to inform irq handler
> not to call this API.
>
> Signed-off-by: David Paris <david.paris@st.com>

Patch applied - had to rebase it, strangely the struct is different in
my tree (check that you're in sync).

Yours,
Linus Walleij
