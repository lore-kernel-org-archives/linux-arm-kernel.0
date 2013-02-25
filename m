From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 13:49:30 +0000
Subject: [PATCH 0/2] VGIC fixes for 3.9-rc1
In-Reply-To: <1361558446-8375-1-git-send-email-marc.zyngier@arm.com>
References: <1361558446-8375-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130225134930.GB25276@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 06:40:44PM +0000, Marc Zyngier wrote:
> I've just realised that these patches have never been on LAKML, and
> only to kvm-arm. It is probably better to repost them here before they
> get pulled in.
> 
> The first patch is just a cleanup, and has very little consequence on
> the behaviour of the VGIC. The second one is more serious, and results
> in lost interrupts under heavy load.
> 
> Patches are against mainline as of today, and tested on both TC2 and
> arm64 model.

I'm probably turning up late to this party, but after wrapping my head
around the vgic once again:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

for these two patches.

Will
