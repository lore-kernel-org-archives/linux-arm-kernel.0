From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Jun 2015 22:26:18 +0000 (UTC)
Subject: [PATCHv4 05/10] ARM: DRA7: hwmod: set DSS submodule parent hwmods
In-Reply-To: <1433139798-23450-6-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-6-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1506012224120.14902@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Jun 2015, Tomi Valkeinen wrote:

> Set DSS core hwmod as the parent for all the DSS submodules.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

By the way, for commits like this one, it would be nice to add a line 
describing why the change is needed to the commit message.  Something like 
"This ensures that the parent hwmods are enabled before any DSS 
submodules are accessed."  Tony, feel free to add that to the commit 
message if you think it's useful.


- Paul
