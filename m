From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Apr 2012 15:00:11 +0200
Subject: [PATCH V3 1/4] SPEAr: Remove existing padmux support for SPEAr
In-Reply-To: <e45ccf333041c3aa12b7dd821545d5e436c9d1ec.1334207964.git.viresh.kumar@st.com>
References: <cover.1334207964.git.viresh.kumar@st.com>
 <e45ccf333041c3aa12b7dd821545d5e436c9d1ec.1334207964.git.viresh.kumar@st.com>
Message-ID: <CACRpkdY=5X9Nz+GFY5g0pHgEpfHOEm46R9LBeAWcD7s31pkFDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 7:24 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> We must use pinctrl framework instead of defining per SoC pinmux drivers. This
> patch removes existing padmux support present for SPEAr platform.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

FWIW: Acked-by: Linus Walleij <linus.walleij@linaro.org>

But I think Viresh is the maintainer of these files :)

Yours,
Linus Walleij
