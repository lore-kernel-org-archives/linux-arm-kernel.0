From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 19:10:33 +0200
Subject: [PATCH 06/11] fsmc/nand: Modify the wait to uninterruptible
In-Reply-To: <3dcb002d0ad03dde9a91e8128dbaa320b8a264a9.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <3dcb002d0ad03dde9a91e8128dbaa320b8a264a9.1349778821.git.vipin.kumar@st.com>
Message-ID: <CACRpkdYj2o77fLWM8vwpCSSuQkJAwOx5gNhCQd+yZ8SJ4M328Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 12:44 PM, Vipin Kumar <vipin.kumar@st.com> wrote:

> Interruptible wait caused trouble in fsmc hardware state machine if the
> application was killed abruptly. To make fsmc operation safe turn wait in to
> un-interruptible.
>
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>

Yes this is wise.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
