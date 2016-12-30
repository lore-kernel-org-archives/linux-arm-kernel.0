From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Dec 2016 08:10:31 -0200
Subject: [PATCH v2] bus: imx-weim: Fix the "fsl, weim-cs-gpr" lookup method
In-Reply-To: <20161230064650.GN6177@dragon>
References: <1480089861-28025-1-git-send-email-festevam@gmail.com>
 <20161230064650.GN6177@dragon>
Message-ID: <CAOMZO5DcGZgSdj4iO0poo1WLn-WFmaW5JBeb7Au2Ved7NXDuOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 4:46 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> "fsl,weim-cs-gpr" is *not* a compatible string, while
> what syscon_regmap_lookup_by_compatible() does is to find a syscon node
> by its compatible string.

Ops, sorry about that. I sent a v3, which hopefully looks better.
