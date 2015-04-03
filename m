From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 3 Apr 2015 19:03:04 +0000 (UTC)
Subject: [PATCHv2 03/10] ARM: DRA7: hwmod: set DSS submodule parent hwmods
In-Reply-To: <1427208910-17678-4-git-send-email-tomi.valkeinen@ti.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
 <1427208910-17678-4-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1504031902470.19540@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Mar 2015, Tomi Valkeinen wrote:

> Set DSS core hwmod as the parent for all the DSS submodules.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.  Will send a pull request for this to Tony today, but it  
may not make it for v4.1.  

Note that I cannot boot test this since I do not have a DRA7xx board.


- Paul
