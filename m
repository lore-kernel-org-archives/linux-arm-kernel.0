From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 08:48:38 +0200
Subject: Question about multi-bank memory usage in ARM platform
In-Reply-To: <BANLkTik2wzXouKNcBAJ6AJr0fjAuaOjwJw@mail.gmail.com>
References: <BANLkTik2wzXouKNcBAJ6AJr0fjAuaOjwJw@mail.gmail.com>
Message-ID: <20110510064838.GH18791@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	A minimum of respect will to put your name in the e-mail
	and hide the chip and other information will not convince people to
	help you.

	my 0.02$

Best Regards,
J.
On 13:45 Tue 10 May     , os user wrote:
> Hi Russell and list,
> 
> I have a question about multi-bank memory usage in ARM platform (arm926).
> 
> I have two banks of SDRAM, one is  64M at 0x20000000, another is
> 64M at 0x60000000. I tried to use both of them in Linux (2.6.38). I hope
> the kernel will print
> 
> Memory: 128MB = 128MB total
> Memory: 126236KB available (xxx code, xxx data, 112K init, 0K highmem)
> 
> So I tried passing 'mem=64M at 0x20000000 mem=64M at 0x60000000' to Kernel
> command line.
> 
> >From the kernel message, I failed to achieve my goal. The kernel says,
> 
> Ignoring RAM at 60000000-63ffffff (vmalloc region overlap).
> 
> Could you or someone else please give me a hint how to deal with this?
> 
> Thanks a lot.
> 
> BR
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
