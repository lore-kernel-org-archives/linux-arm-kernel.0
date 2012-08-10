From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Aug 2012 15:49:22 +0100
Subject: [RFC 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <50229944.60603@free-electrons.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
 <1344438307-8468-4-git-send-email-gregory.clement@free-electrons.com>
 <20120808151946.GE4579@mudshark.cambridge.arm.com>
 <50229422.40305@free-electrons.com>
 <50229944.60603@free-electrons.com>
Message-ID: <20120810144922.GH2066@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 05:52:20PM +0100, Gregory CLEMENT wrote:
> On 08/08/2012 06:30 PM, Gregory CLEMENT wrote:
> > Yes indeed this SoC support LPAE.
> 
> Well Armada XP supports LPAE but don't use any outer cache functions, he works
> with the Aurora cache controller on 'system cache'.
> Armada 370 uses this outer cache functions but doesn't support LPAE.

Can the Armada 370 be configured to use the co-processor interface to the
L2, or does only the Armada XP support that feature? What happens if you
build a single zImage supporting both of the SoCs?

Will
