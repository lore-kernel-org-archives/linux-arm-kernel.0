From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jan 2018 02:03:15 +0100
Subject: [PATCH 02/14] mmc: mmci: Don't pretend all variants to have
 MCI_STARBITERR flag
In-Reply-To: <1515759368-16946-3-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
 <1515759368-16946-3-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdYJLkqKnu4Yh65j4KhcUcx6yW+944=V8nP+yvxYWNX+4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 1:15 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> This patch prepares for supporting the STM32 variant that
> has no such bit in the status register.
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
