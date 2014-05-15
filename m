From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 May 2014 09:34:44 -0400
Subject: [PATCH v6 17/17] ARM: mvebu: add Device Tree description of
 the EHCI controller on Armada 375
In-Reply-To: <5374C08C.7040700@cogentembedded.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
 <1400149062-32661-18-git-send-email-gregory.clement@free-electrons.com>
 <5374C08C.7040700@cogentembedded.com>
Message-ID: <20140515133444.GN27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 05:26:36PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/15/2014 02:17 PM, Gregory CLEMENT wrote:
> 
> >The Marvell Armada 375 SoCs contains one EHCI controller. This commit
> 
>    However, you're adding two. :-)

So it would seem.  Gregory, I'll fix it up when I pull it in.  No need
to respin.

thx,

Jason.
