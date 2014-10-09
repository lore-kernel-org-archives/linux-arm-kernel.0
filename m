From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Oct 2014 15:46:37 -0500
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141009204101.GA25955@debian>
References: <20140904191642.GJ5001@linux.vnet.ibm.com>
 <20140904192535.GJ13421@saruman.home>
 <20140904200403.GL13421@saruman.home>
 <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman>
 <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian>
Message-ID: <20141009204637.GE25729@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 10:41:01PM +0200, Rabin Vincent wrote:
> On Thu, Oct 09, 2014 at 11:26:56AM -0500, Felipe Balbi wrote:
> > alright, it's pretty deterministic however. Always on the same test, no
> > matter which USB controller, no matter if backing store is RAM or MMC.
> > 
> > Those two undefined instructions on the disassembly caught my attention,
> > perhaps I'm facing a GCC bug ?
> 
> The undefined instructions are just ARM's BUG() implementation.
> 
> But did you see the question I asked you yesterday in your other thread?
> http://www.spinics.net/lists/arm-kernel/msg368634.html

hmm, completely missed that, sorry. I'm using 4.8.2, will try something
else.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141009/422ce589/attachment.sig>
