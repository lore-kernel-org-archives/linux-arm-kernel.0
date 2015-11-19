From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 19 Nov 2015 16:26:11 +0000
Subject: [PATCH] ARM: xip: Move XIP linking to a separate file
In-Reply-To: <564DF6F2.5090808@suse.com>
References: <1447943047-22427-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511191050080.22569@knanqh.ubzr>
 <HK2PR06MB0561F1A746E04D0A205B2DBB8A1B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <564DF6F2.5090808@suse.com>
Message-ID: <HK2PR06MB0561EC19AE06D509A4E408B98A1B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Nov 2015, Michal Marek wrote:
> UM even uses it in its linker script:
> 
> arch/um/kernel/vmlinux.lds.S:#include "uml.lds.S"
> arch/um/kernel/vmlinux.lds.S:#include "dyn.lds.S"


"When in Rome, ..."
