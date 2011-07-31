From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:24:56 +0200
Subject: [PATCH 10/18] dmaengine/amba-pl08x: Get rid of
	pl08x_pre_boundary()
In-Reply-To: <c147ba3a755935e93fdb40b5531a6e18d34e0fd7.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<c147ba3a755935e93fdb40b5531a6e18d34e0fd7.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MrBB_QEn4Psa9aeyNLvF86oM-KnaNiFZ5=zMVkz_U5GOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> Based on above discussion, this patch removes all code related to 1 KB boundary
> as we are not required to handle this in driver.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

OMG yes that makes perfect sense. I questioned this in the past and was
pointed to the same manual page.

What is fun is that the code was written by ARM.

Let's merge this and I'll test it on the PB11MPCore, I think Mem2Mem
with the DMA engine compile-in tests may work on a few other boards as
well so maybe Russell can test it too.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
