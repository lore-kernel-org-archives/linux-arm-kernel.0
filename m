From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2011 19:08:48 +0000
Subject: [PATCH 1/4] [RFC] Add generic ARM instruction set condition
 code checks.
In-Reply-To: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
Message-ID: <20111121190848.GS9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 06:30:46PM +0000, Leif Lindholm wrote:
> +/*
> + * Returns:
> + * 0 - if condition fails
> + * 1 - if condition passes (including AL)
> + * 2 - if unconditional encoding (or before ARMv3, NV condition)

The comment is wrong.  NV always meant 'never execute' including v3,
v4 and v5 architectures.
