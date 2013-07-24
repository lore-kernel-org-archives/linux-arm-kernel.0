From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 16:05:43 +0100
Subject: [PATCH 07/14] ARM: smp_scu: data endian fixes
In-Reply-To: <1374661682-9349-8-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-8-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130724150543.GP11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:27:55AM +0100, Ben Dooks wrote:
> The smp_scu driver needs to use the relaxed readl/write accessors
> to avoid any issues with the endian mode the processor core is in.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
