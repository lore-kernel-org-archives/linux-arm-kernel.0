From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 18 Dec 2014 14:42:14 +0000
Subject: [PATCH 2/4] arm64: GICv3: change unsigned types for AArch32
 compatibility
In-Reply-To: <5492D628.50708@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
 <1418307788-17977-3-git-send-email-jean-philippe.brucker@arm.com>
 <5492D628.50708@arm.com>
Message-ID: <20141218144214.GB2652@e106794-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 01:27:04PM +0000, Vladimir Murzin wrote:
> Hi Jean,
> 
> On 11/12/14 14:23, Jean-Philippe Brucker wrote:
> > -static int gic_populate_rdist(void)
> > +static int __init gic_populate_rdist(void)
>               ^^^^^^
> This change breaks cpu hotplug. Is it intentional?
> 
No, that must be a rebase mistake.

Thanks,
Jean
