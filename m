From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jul 2011 21:02:44 -0400 (EDT)
Subject: ARM: kprobes: Add support for Thumb-2
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1107112046490.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Jul 2011, Tixy wrote:

> This patch series adds support for kprobes on Thumb-2 kernels.
> This requires making the framework handle Thumb breakpoints and adding
> simulation and emulation routines for the Thumb instruction set.
> 
> Note, this series also modifies the existing behaviour in the case when
> probes are placed on conditionally executed instructions (see patch 15).

Pretty nice and well organized patch series.  This is excellent work !

Although I didn't reply to all the patches, I've read them all and you 
can add "Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>" to all of 
them after the already posted comments are addressed.

I know that you also developed a comprehensive test suite in parallel to 
validate all this code.  I'm therefore pretty confident it'll work as 
well if not better than the existing code we had in the tree for quite a 
while before you started working on it.

I think this is ready to be merged with Russell whenever you are done 
with those small fixes.


Nicolas
