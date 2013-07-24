From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 17:25:30 +0100
Subject: [PATCH 14/14] ARM: set --be8 when linking modules
In-Reply-To: <1374661682-9349-15-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-15-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130724162530.GT11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:28:02AM +0100, Ben Dooks wrote:
> To avoid having to make every text section swap the instruction order
> of all instructions, make sure modules are built also built with --be8
> (as is the current kernel final link).
> 
> If we do not do this, we would end up having to swap all instructions
> when loading a module, instead of just the instructions that we are
> applying ELF relocations to.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
