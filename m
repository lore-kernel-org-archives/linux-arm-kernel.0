From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:30:01 +0200
Subject: [PATCH 13/18] dmaengine/amba-pl08x: Align lli_len to
	max(src.width, dst.width)
In-Reply-To: <afe9e5154d96c0f44c64c411c98b5db75969db6c.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<afe9e5154d96c0f44c64c411c98b5db75969db6c.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MobCaCNLf_GTm=1T=nBWB8pe8_dYQUx77XKnceNGtGogw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> Currently lli_len is aligned to min of two widths, which looks to be incorrect.
> Instead it should be aligned to max of both widths.

Again, a great and well researched patch.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
