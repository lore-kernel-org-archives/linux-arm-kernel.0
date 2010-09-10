From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 10 Sep 2010 09:51:43 +0530
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <AANLkTinri8ve=wb+tm5zO4JSnz6_RE-n+sZoKU-ipios@mail.gmail.com>
References: <cover.1283161023.git.viresh.kumar@st.com>	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>	<4C7F5B9E.8090406@st.com>	<AANLkTikwjCh=2Cekg9R1SqacKXC+_ZgV7m+=ZVVCaDba@mail.gmail.com>	<4C7F9993.3040700@st.com>	<20100903112338.GA3132@morgana.i.gnudd.com>
	<AANLkTinri8ve=wb+tm5zO4JSnz6_RE-n+sZoKU-ipios@mail.gmail.com>
Message-ID: <4C89B257.4000202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/2010 10:56 PM, Linus Walleij wrote:
>> > Note however that the platform data in
>> > arch/arm/mach-nomadik/board-nhk8815.c should be fixed to reference the
>> > new driver.  If you remove my version please at least compile-check
>> > the nhk with the new patch-set.
> What about we put this new FSMC generic thing in, and
> then remove the old one with the same patch that
> instead activates the new one. No need to rush that.
> 
> Right now I mostly worry about having it in the proper
> place with the proper name and the headers accessible from
> all archs...

Linus,

Sorry for replying late!!!

The solution looks fine to us, but currently we don't have
enough bandwidth to rework on the suggested solution.

Maybe, we can go ahead with current patch, get it acked. Then send another
patch later to fix mentioned issues.

How do you suggest to proceed on this?

viresh.
