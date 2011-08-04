From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Aug 2011 12:16:44 +0200
Subject: spi/spi-pl022: Query on working of DMA mode
In-Reply-To: <4E3A147B.9060305@st.com>
References: <4E3931B7.3010400@st.com>
	<CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
	<4E3A147B.9060305@st.com>
Message-ID: <CACRpkdZW2tj=JdfqFzif_bPt0UJ8wOmsMuOeBhSjH4+qUA3pSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2011 at 5:39 AM, viresh kumar <viresh.kumar@st.com> wrote:

>>> > Is DMA mode working in your case?
>> Yes, magically :-/
>
> But how? Don't you have any message with more than one transfer in it?

No maybe not, my test cases are for single messages, and on production
systems we mainly use IRQ-driven traffic. I need to have these
tests added I believe :-/

If you fix this up it will be much appreciated!

Thanks,
Linus Walleij
