From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 11:40:20 +0000
Subject: [PATCH v2] [ARM] Dove: add support for CM-A510 machine.
In-Reply-To: <1289820154-7135-1-git-send-email-mike@compulab.co.il>
References: <1289820154-7135-1-git-send-email-mike@compulab.co.il>
Message-ID: <1289821220.20612.30.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Some minor comments below:

On Mon, 2010-11-15 at 11:22 +0000, Mike Rapoport wrote:
> From: Konstantin Sinyuk <kostyas@compulab.co.il>
> 
> Hi Nicolas,
> Can you please add the below patch to your orion tree?
> Saeed has already reviewed and approved the prevoius version.

Some better description of the patch rather than internal
communication :)

> v2 changes:
> * rebase on top of current Linus tree
> * remove .phys_io and .io_pg_offst from machine description

The changelog can go after the '---' line.

> ---
> Signed-off-by: Konstantin Sinyuk <kostyas@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

The signed-off-by lines will be ignored by 'git am' as they come after
the '---' line. Should be moved above.

-- 
Catalin
