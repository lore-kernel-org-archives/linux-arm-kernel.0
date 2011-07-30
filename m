From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 31 Jul 2011 00:34:28 +0200
Subject: [PATCH 05/18] dmaengine/amba-pl08x: Changing few prints to
	dev_dbg from dev_info
In-Reply-To: <7ef7d86e78a74b140c7c5a87fd2b7a117120ce6f.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<7ef7d86e78a74b140c7c5a87fd2b7a117120ce6f.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2Mr-GE3o1zQ+Rg=drzJ9U=PoGAXMx6iR43ds0CWmU1sFcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> For 8 memory and 16 slave channels 35 boot print lines are printed. And that is
> too much. Most of this would be more useful for debugging. So moving few of them
> to dev_dbg instead of dev_info. Now only 3 prints will be printed.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Oh I really liked these prints but whatever.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
