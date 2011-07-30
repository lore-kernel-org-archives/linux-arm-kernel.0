From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 00:16:31 +0200
Subject: [PATCH 01/18] ARM: asm/pl080.h: Protect against multiple
	inclusion of header file
In-Reply-To: <cbd8c0a36115615ea0d80055de7a27ef1b8b7ce6.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<cbd8c0a36115615ea0d80055de7a27ef1b8b7ce6.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2Mo9ABNfePnSfKjZeOtHr0JpkGO76x+=qtQp+XaEdtWWVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> <asm/hardware/pl080.h> doesn't have protection to deal with multiple inclusion.
> And so we get compilation errors in cases where this file is included more than
> once. This patch adds #ifdefs at the top of file to protect it against multiple
> inclusions.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Good idea.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
