From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Jul 2011 08:20:59 +0100
Subject: [PATCH 37/51] ARM: kprobes: Optimise emulation of LDM and STM
In-Reply-To: <alpine.LFD.2.00.1107112037190.14596@xanadu.home>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-38-git-send-email-tixy@yxit.co.uk>
	<alpine.LFD.2.00.1107112037190.14596@xanadu.home>
Message-ID: <1310455259.2258.10.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-11 at 20:45 -0400, Nicolas Pitre wrote: 
> On Sat, 9 Jul 2011, Tixy wrote:
> > The approach taken to optimisation is to use simulation rather than
> > emulation,
> 
> Isn't it the other way around i.e. emulation rather than simulation?

It is.

-- 
Tixy 
