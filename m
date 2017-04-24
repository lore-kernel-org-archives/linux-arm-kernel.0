From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 14:20:37 +0200
Subject: [PATCH v2 1/7] pinctrl: stm32: add possibility to use gpio-ranges
 to declare bank range
In-Reply-To: <1491568984-20169-2-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdbsaUeAW3_gG9JqJHpWMfZV_JDr_nnOUdfwsHBpZ4jX3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 2:42 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> Use device tree entries to declare gpio range. It will allow to use
> no contiguous gpio bank and holes inside a bank.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Patch applied.

Yours,
Linus Walleij
