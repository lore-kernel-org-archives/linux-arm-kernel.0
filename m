From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 15 Feb 2011 23:03:30 -0500 (EST)
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1102152257500.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Feb 2011, vb at vsbe.com wrote:

> hello all,
> 
> I am trying to compile the 2.6.37 kernel in THUMB2 mode and am
> experiencing some compilation problems. Some inline assembly in some
> files uses commands inappropriate for THUMB2 mode.
> 
> I wonder if the kernel is expected to compile cleanly when
> CONFIG_THUMB2_KERNEL is enabled (and I am doing something wrong), or
> is it know not to compile/work in Thumb2 node for any reason?

It is known not to compile in mainline right now depending on your 
target, but fixes are slowly being merged upstream.

Dave Martin is maintaining a Git tree with all the fixes required for 
Thumb2 here (see the Thumb2 related branches):

http://git.linaro.org/gitweb?p=people/dmart/linux-2.6-arm.git;a=summary

Beware that some patches might not be final yet.


Nicolas
