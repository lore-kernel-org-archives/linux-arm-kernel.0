From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Oct 2013 12:42:31 +0100
Subject: [PATCH 12/23] ARM: traps: use <asm/opcodes.h> to get correct
 instruction order
In-Reply-To: <1381271679-27804-13-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
 <1381271679-27804-13-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20131009114231.GE6564@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:34:28PM +0100, Ben Dooks wrote:
> The trap handler needs to take into account the endian configuration of
> the system when loading instructions. Use <asm/opcodes.h> to provide the
> necessary conversion functions.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/kernel/traps.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
