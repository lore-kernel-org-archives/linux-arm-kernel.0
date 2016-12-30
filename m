From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 09:07:30 +0100
Subject: [PATCH] pinctrl: stm32: activate strict mux mode
In-Reply-To: <1481725456-1030-1-git-send-email-gabriel.fernandez@st.com>
References: <1481725456-1030-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <CACRpkdaNTk27t40K=q95Pqk0gv_dt2N3MF6_FsAu7vdb9uHnig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 3:24 PM,  <gabriel.fernandez@st.com> wrote:

> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> This activates strict mode muxing for the STM32 pin controllers,
> as these do not allow GPIO and functions to use the same pin
> simultaneously.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Patch applied with Patrice's ACK.

Yours,
Linus Walleij
