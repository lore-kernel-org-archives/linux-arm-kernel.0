From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 16 Feb 2012 13:31:41 -0500 (EST)
Subject: Question: how to make one page readonly on ARM
In-Reply-To: <CAADzPW3FvBrupA-Vocdk6Xxn_2y4_3ar57wPTLft5H3FgEHP7g@mail.gmail.com>
References: <CAADzPW2bW8Rx+V726L+Mfji+-+rFxwwYO0nkKtgMTM0XtQ7BpQ@mail.gmail.com>
 <20120216085537.GJ13673@n2100.arm.linux.org.uk>
 <CAADzPW3FvBrupA-Vocdk6Xxn_2y4_3ar57wPTLft5H3FgEHP7g@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1202161329460.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Feb 2012, ??? wrote:

> 2012/2/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Thu, Feb 16, 2012 at 12:54:27PM +0800, ??? wrote:
> >> Hi,
> >> I get one page by __get_free_page and can make it readonly by
> >> set_memory_ro on X86,
> >> but how to do this on ARM?
> >
> > You can't, because we map all kernel space with 1MB section mappings.
> 
> sorry, I don't quite understand. I am kernel newbie.
> Do you mean that if I want to make one memory region readonly, it has
> to be in MB unit?
> Does ARM kernel have any functions similar to set_memory_ro?

No.

Maybe if you tell us more about what your end goal is, we might be able 
to suggest alternatives for solving your problem.


Nicolas
