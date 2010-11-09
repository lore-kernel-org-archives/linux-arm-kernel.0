From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 09 Nov 2010 14:22:53 +0000
Subject: [PATCH 6/6] ARM: ftrace: enable function graph tracer
In-Reply-To: <20101109134644.GA3163@debian>
References: <1289067954-5080-1-git-send-email-rabin@rab.in>
	<1289067954-5080-6-git-send-email-rabin@rab.in>
	<AANLkTin8UO9ixVep0jKK8H5roWEVRDJW4khUpT2TpPs+@mail.gmail.com>
	<20101108091858.GP16938@pengutronix.de>
	<AANLkTinmSn1fqKv8sCCP8d0-_0HsLrhtorXvHCovOYve@mail.gmail.com>
	<20101109134644.GA3163@debian>
Message-ID: <1289312573.11461.18.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-11-09 at 13:46 +0000, Rabin Vincent wrote:
> Subject: [PATCHv2] ARM: ftrace: enable function graph tracer
> 
> Add the options to enable the function graph tracer on ARM.  Function
> graph tracer support requires frame pointers, so exclude Thumb-2 and
> also make sure FRAME_POINTER gets enabled when FUNCTION_GRAPH_TRACER is
> used, since FUNCTION_TRACER doesn't "select FRAME_POINTER" when
> ARM_UNWIND is used.  Therefore, with GCC 4.4.0+, you get plain function
> tracing without frame pointers, but you'll need them if you want
> function graph tracing.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Looks ok to me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
