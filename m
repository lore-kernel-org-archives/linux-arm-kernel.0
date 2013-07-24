From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 15:28:26 +0100
Subject: [PATCH 02/14] ARM: asm: Add ARM_BE8() assembly helper
In-Reply-To: <1374661682-9349-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130724142825.GK11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:27:50AM +0100, Ben Dooks wrote:
> Add ARM_BE8() helper to wrap any code conditional on being
> compile when CONFIG_ARM_ENDIAN_BE8 is selected and convert
> existing places where this is to use it.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Will Deacon <will.deacon@arm.com>

We could probably add a similar ARM_LE helper to clean up the
__LITTLE_ENDIAN definitions in arch/arm/net/bpf_jit_32.c too.

Will
