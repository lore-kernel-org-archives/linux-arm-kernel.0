From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 Jan 2015 17:36:05 +0100
Subject: [PATCH 10/17] ARM: at91: merge SOC_AT91SAM9xxx
In-Reply-To: <54C0CF5D.8020902@atmel.com>
References: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421359100-8930-11-git-send-email-alexandre.belloni@free-electrons.com>
 <54C0CF5D.8020902@atmel.com>
Message-ID: <20150122163605.GC19922@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/2015 at 11:22:21 +0100, Nicolas Ferre wrote :
> Le 15/01/2015 22:58, Alexandre Belloni a ?crit :
> > Only use SOC_AT91SAM9 for all the at91sam9 SoCs.
> > 
> > It enables HAVE_AT91_SMD and HAVE_AT91_UTMI for all the sam9 SoCs but this only
> > represents 96 bytes of uncompressed kernel code.
> 
> After this patch that removes all the CONFIG_SOC_AT91SAM9xxxx options
> excepted CONFIG_SOC_AT91SAM9, I still see a lot of them remaining in the
> source tree.
> 
> So, this patch is not complete in my opinion. Even if you remove these
> options later on, why not suppress them here?
> 

They went through other branches (you were in copy).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
