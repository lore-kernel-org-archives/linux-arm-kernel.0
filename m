From: dwalker@codeaurora.org (dwalker at codeaurora.org)
Date: Mon, 24 May 2010 10:04:18 -0700 (PDT)
Subject: [PATCH] ARM: Continue removing useless bootmem.h includes
In-Reply-To: <20100523094220.GB950@n2100.arm.linux.org.uk>
References: <20100523094220.GB950@n2100.arm.linux.org.uk>
Message-ID: <db79dbda77b67de387b63d8f00653e60.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Catch those which have been missed by 6262c92f because they were
> submitted via other routes.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> I'm working towards reducing ARM's usage of the bootmem code, with a
> view to eventually removing it entirely.  As nothing in these files
> uses bootmem, we can kill off the include.
>
> Ack would be preferable.

Acked-by: Daniel Walker <dwalker@codeaurora.org>
