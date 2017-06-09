From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 10:03:43 +0200
Subject: [PATCH] pinctrl: stm32: remove useless check
In-Reply-To: <1496221843-10697-1-git-send-email-alexandre.torgue@st.com>
References: <1496221843-10697-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdbp8MKdH5UzTZN5UExZupj5Bo7JVqfPAqgg3QYi4hjFqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 11:10 AM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> There is no link between the number of elements of tab which contains all
> pin desc (located in each pinctrl-stm32xxxx.c files) and the pin number
> (defined in the tab).
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Patch applied.

Yours,
Linus Walleij
