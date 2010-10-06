From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 06 Oct 2010 10:07:38 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <alpine.LFD.2.00.1010061257080.3107@xanadu.home>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<alpine.LFD.2.00.1010052246380.3107@xanadu.home>
	<1286372886.22265.63.camel@m0nster>
	<alpine.LFD.2.00.1010061016280.3107@xanadu.home>
	<1286376581.22265.85.camel@m0nster>
	<alpine.LFD.2.00.1010061109110.3107@xanadu.home>
	<1286379197.22265.95.camel@m0nster>
	<alpine.LFD.2.00.1010061144560.3107@xanadu.home>
	<1286380480.22265.109.camel@m0nster>
	<alpine.LFD.2.00.1010061207090.3107@xanadu.home>
	<1286383243.22265.124.camel@m0nster>
	<alpine.LFD.2.00.1010061257080.3107@xanadu.home>
Message-ID: <1286384858.22265.125.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-06 at 13:02 -0400, Nicolas Pitre wrote: 
> > Are you saying it's not needed for either the __dcc_putchar or
> > __dcc_getchar ?
> 
> I'm saying that "CC" is unneeded in those cases where the condition flag 
> is unmodified.  Those are the !CONFIG_CPU_V7 cases.

Ok .. I can drop that stuff then.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
