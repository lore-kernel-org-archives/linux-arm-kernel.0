From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 4 Aug 2011 15:52:53 +0530
Subject: spi/spi-pl022: Query on working of DMA mode
In-Reply-To: <CACRpkdZW2tj=JdfqFzif_bPt0UJ8wOmsMuOeBhSjH4+qUA3pSA@mail.gmail.com>
References: <4E3931B7.3010400@st.com>	<CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>	<4E3A147B.9060305@st.com>
	<CACRpkdZW2tj=JdfqFzif_bPt0UJ8wOmsMuOeBhSjH4+qUA3pSA@mail.gmail.com>
Message-ID: <4E3A72FD.6060404@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2011 03:46 PM, Linus Walleij wrote:
> No maybe not, my test cases are for single messages, and on production
> systems we mainly use IRQ-driven traffic. I need to have these
> tests added I believe :-/
> 
> If you fix this up it will be much appreciated!

Ya I am fixing this up. I have resolved this yesterday only, with GFP_NOWAIT.
But it looks there are few more issues. Let me fix everything first
and then will send patchset with updates.

-- 
viresh
