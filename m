From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 17 Sep 2012 18:31:21 -0400 (EDT)
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for clean
 and flush range
In-Reply-To: <5057881A.9020604@gmail.com>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
 <1347890398-22088-1-git-send-email-robherring2@gmail.com>
 <20120917194733.GQ12245@n2100.arm.linux.org.uk> <5057881A.9020604@gmail.com>
Message-ID: <alpine.LFD.2.02.1209171827260.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Sep 2012, Rob Herring wrote:

> On 09/17/2012 02:47 PM, Russell King - ARM Linux wrote:
> > Plus, because there's little justification behind this patch (apart
> > from a vague reference to the speed of IO accesses) I'm going to say
> > NAK to this until further information is forthcoming justifying this
> > change.
> > 
> 
> 30% faster network transmit rate with pktgen on highbank.

Please always include your benchmark results in the patch description. 
That is highly valuable information when looking at commit logs.


Nicolas
