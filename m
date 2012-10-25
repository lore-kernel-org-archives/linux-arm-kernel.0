From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Oct 2012 13:07:19 +0100
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <5086FEEC.5090203@free-electrons.com>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121011130955.GP4625@n2100.arm.linux.org.uk> <5076CA43.9070503@gmail.com>
 <20121011134130.GQ4625@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1210111103230.16518@xanadu.home>
 <5086FEEC.5090203@free-electrons.com>
Message-ID: <20121025120719.GA21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 10:32:44PM +0200, Gregory CLEMENT wrote:
> So is there a chance that this patch will be applied for 3.7?
> 
> Currently I can't boot anymore Armada XP or Armada 370, if kernel is
> compressed in LZO. It's annoying.
> 
> Russell, did Nicolas manage to convince you?

Frankly, no - less so now that we have a question mark over ARMv6 which
seems to conflict with Nicolas' justification.  This issue is larger than
just ARMv7...
