From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:41:45 +0200
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len
	greater than one for slave transfers
In-Reply-To: <5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MpAc7n9VARyj0cB8mOmsEAcZWq4rrj8oJyMa4Lp9JAh+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> Untill now, sg_len greater than one is not supported. This patch adds support to
> do that.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Thanks, was on my TODO once.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
