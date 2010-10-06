From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 06 Oct 2010 12:35:43 -0700
Subject: [PATCH 1/3] [ARM] Translate delay.S into (mostly) C
In-Reply-To: <4CACC053.2090509@codeaurora.org>
References: <1285644827-6846-1-git-send-email-sboyd@codeaurora.org>
	<1285644827-6846-2-git-send-email-sboyd@codeaurora.org>
	<1286299355.18791.11.camel@c-dwalke-linux.qualcomm.com>
	<4CABEECB.4030301@codeaurora.org>
	<alpine.LFD.2.00.1010061024220.3107@xanadu.home>
	<4CACC053.2090509@codeaurora.org>
Message-ID: <1286393743.22265.129.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-06 at 11:30 -0700, Stephen Boyd wrote:
> Is there some way to force GCC to do what I want (interleave the
> functions)? It seems happy to inline them and then optimize the
> register
> usage and instruction ordering. Perhaps that is OK though and we're
> wasting our time trying to be conservative in code size. 

Is it possible to do all this in assembly ? Can't you have the default
implementation using this assembly with different function names, then
just set the assembly function names in C code someplace?

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
