From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 01:56:25 +0200
Subject: [PATCH 2/2] pinctrl: stm32: move gpio irqs binding to optional
In-Reply-To: <1476970012-7838-3-git-send-email-alexandre.torgue@st.com>
References: <1476970012-7838-1-git-send-email-alexandre.torgue@st.com>
 <1476970012-7838-3-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdYne7Kjk_Bw-j6E6SPvx4z7G_5AzfHwYJi70F=DvguAxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 3:26 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> stm32 pinctrl driver could be probed even if no interrupt controller
> is defined to manage gpio irqs. Entries related to gpio irq management
> are moved to optional.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Patch applied for fixes.

Yours,
Linus Walleij
