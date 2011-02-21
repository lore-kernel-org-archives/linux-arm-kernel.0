From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 20 Feb 2011 22:41:22 -0500 (EST)
Subject: bug in arm_kprobe_decode_insn
In-Reply-To: <20110220182437.GA24789@joi.lan>
References: <20110220182437.GA24789@joi.lan>
Message-ID: <alpine.LFD.2.00.1102202239570.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Feb 2011, Marcin Slusarz wrote:

> Hi
> 
> In arch/arm/kernel/kprobes-decode.c there's a function arm_kprobe_decode_insn
> which does:
> 
> } else if ((insn & 0x0e000000) == 0x0c400000) {
> ...
> 
> This is always false, so code below is dead.

Good catch, thanks.


Nicolas
