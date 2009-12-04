From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 04 Dec 2009 12:37:14 -0500 (EST)
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <771cded00912032141x368ae423n6603edbd7acd3f10@mail.gmail.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<771cded00912032141x368ae423n6603edbd7acd3f10@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0912041234290.31174@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Dec 2009, Haojian Zhuang wrote:

> > + ? ? ? .long ? cpu_pj4_name
> > + ? ? ? .long ? v6_processor_functions
> > + ? ? ? .long ? v6wbi_tlb_fns
> > + ? ? ? .long ? v6_user_fns
> > + ? ? ? .long ? v6_cache_fns
> > + ? ? ? .size ? __v6_proc_info, . - __v6_proc_info
> You created __pj4_v6_proc_info. But you still used __v6_proc_info at 
> here. Why?

I fixed that one already when committing the patch into Git.


Nicolas
