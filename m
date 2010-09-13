From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 13 Sep 2010 06:37:12 +0200
Subject: [PATCH 03/74] ST SPEAr: Formalized timer support
In-Reply-To: <4C8DA2DC.8080502@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<eed779f7085ed5686aceb61b48a2c2a7d6af5953.1283161023.git.viresh.kumar@st.com>
	<20100906225536.GD8153@game.jcrosoft.org> <4C8D9909.4040705@st.com>
	<20100913033704.GB11822@game.jcrosoft.org>
	<4C8DA2DC.8080502@st.com>
Message-ID: <20100913043712.GC11822@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:34 Mon 13 Sep     , Shiraz Hashim wrote:
> Dear Jean,
> 
> On 9/13/2010 9:07 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 08:52 Mon 13 Sep     , Shiraz Hashim wrote:
> >> Dear Jean,
> >>
> >> On 9/7/2010 4:25 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>>  
> >>>> -#endif
> >>>> +static void __init spear3xx_timer_init(void)
> >>>> +{
> >>>> +	spear_setup_timer();
> >>> why not call it directly?
> >>
> >> A single level of abstraction was provided so that if archs (spear3xx/6xx/13xx)
> >> required to do something extra.
> >
> > it does not seems to be needed at all so for now call it directly is enough
> >
> 
> OK. So, I think what could be better is to set the parent clock of the gpt in
> the arch specific function like spear3xx_timer_init. This would also remove this
> part from the timer code.
ok

Best Regards,
J.
