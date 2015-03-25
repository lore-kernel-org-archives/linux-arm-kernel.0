From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Mar 2015 16:35:36 +0100
Subject: [PATCH v2 2/6] pinctrl: st: Introduce a 'get pin function' call
In-Reply-To: <1426699279-9258-3-git-send-email-lee.jones@linaro.org>
References: <1426699279-9258-1-git-send-email-lee.jones@linaro.org>
 <1426699279-9258-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaOtY7QxnkKLbbsG6hJ+Hrs61PdrP596AD768oUNT4L4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 6:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This call fetches the numerical function value a specified pin is
> currently operating in.  Function zero is more often than not the
> GPIO function.  Greater than zero values represent an alternative
> function.  You'd need to either look those up in the Device Tree
> sources or the Programmer's Manual.
>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Yours,
Linus Walleij
