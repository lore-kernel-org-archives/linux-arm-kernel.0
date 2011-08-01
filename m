From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Aug 2011 16:21:34 -0600 (MDT)
Subject: [PATCH v2] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
In-Reply-To: <1311762839-31663-1-git-send-email-archit@ti.com>
References: <1311762839-31663-1-git-send-email-archit@ti.com>
Message-ID: <alpine.DEB.2.00.1108011619520.28427@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jul 2011, Archit Taneja wrote:

> Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The
> OMAP4430 Public TRM vV has these fields mentioned correctly.

Thanks, queued for 3.2 in the scm_fixes_3.2 branch of 
git://git.pwsan.com/linux-2.6

Also added Santosh's ack.


- Paul
