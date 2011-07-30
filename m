From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 00:36:14 +0200
Subject: [PATCH 06/18] dmaengine/amba-pl08x: Simplify pl08x_ensure_on()
In-Reply-To: <88035b0bd1f3fd755b6a157193c39477e21ec60a.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<88035b0bd1f3fd755b6a157193c39477e21ec60a.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MoHSVae6N=CA-zi3CpaqOrEOqbPCL=orfs5zgxAUOmSnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> Simply writing 1 on bit 0 is sufficient instead of reading and clearing bits.
> Also as per manual, for bit 3-31 of DMACConfiguration register:
> "read undefined, write as 0"
>
> So, we must not rely on values read from this registers bit 3-31.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Obviously correct,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
