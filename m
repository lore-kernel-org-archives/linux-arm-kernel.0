From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 01 Feb 2012 11:26:18 -0500 (EST)
Subject: [PATCH 0/2] Errata workaround updates
In-Reply-To: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
References: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1202011123420.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Feb 2012, Will Deacon wrote:

> Hello,
> 
> After Russell pointed out that we weren't applying an erratum workaround
> in all cases that it was required:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082730.html
> 
> I went back through the documents for PL310 and Cortex-A9 to check that
> what we have in Linux matches the latest workarounds.

Ideally, you should not limit the workaround only to those revisions 
known to be broken but to any revision.  Only when a particular revision 
is known to be fixed then should it be disabled.


Nicolas
