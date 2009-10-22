From: alex@digriz.org.uk (Alexander Clouter)
Date: Thu, 22 Oct 2009 21:38:03 +0100
Subject: [PATCHv3] [ARM] kirkwood: combine support for openrd
	base/client support
In-Reply-To: <alpine.LFD.2.00.0910221412360.21460@xanadu.home>
References: <pbh5r6-os7.ln1@chipmunk.wormnet.eu>
	<20091022124756.56e89d7a@marrow.netinsight.se>
	<20091022110436.GF6085@chipmunk>
	<alpine.LFD.2.00.0910221412360.21460@xanadu.home>
Message-ID: <20091022203803.GU6085@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Nicolas Pitre <nico@fluxnic.net> [2009-10-22 14:19:47-0400]:
>
> On Thu, 22 Oct 2009, Alexander Clouter wrote:
> 
> > The SheevaPlug's do not use this at all ('MACHINE_START(SHEEVAPLUG, 
> > ...)' is not to be seen in there), they already have their own file.
> 
> The openrd_pci_init() is still called with a subsys_initcall() 
> registration.  That would be invoked on a SheevaPlug as well if you have 
> a kernel that supports them both.
>
Right, now I understand, that makes perfect sense.  I'll amend things to 
behave for version 4.

> > If someone wants to merge the SheevaPlug's into here too they can 
> > cross that bridge themselves.
> 
> No way.  I'll bomb the bridge beforehand.  There should be a balance 
> between consolidation and abstraction.
> 
I did not say it was a Good Idea(tm) :)

Cheers

-- 
Alexander Clouter
.sigmonster says: It was Penguin lust... at its ugliest.
