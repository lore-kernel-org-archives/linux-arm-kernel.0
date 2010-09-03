From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Fri, 3 Sep 2010 13:23:38 +0200
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <4C7F9993.3040700@st.com>
References: <4C7F9993.3040700@st.com>
	<cover.1283161023.git.viresh.kumar@st.com>
	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
	<4C7F5B9E.8090406@st.com>
	<AANLkTikwjCh=2Cekg9R1SqacKXC+_ZgV7m+=ZVVCaDba@mail.gmail.com>
Message-ID: <20100903112338.GA3132@morgana.i.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus:
>> As I said I think nomadik_nand.c shall be deleted and replaced with
>> this driver.

Armando:
> As I said before, the SPEAr driver should work on Nomadik too
> as it looks generic enough and for us it is working
> on two different platforms with different FSMC versions.

Ok. I can't test it for a while, so I'll take your word. If needed
I'll make my homework later to fix 8815 over the new driver.

Note however that the platform data in
arch/arm/mach-nomadik/board-nhk8815.c should be fixed to reference the
new driver.  If you remove my version please at least compile-check
the nhk with the new patch-set.

thanks
/alessandro
