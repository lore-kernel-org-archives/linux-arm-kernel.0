From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 09:59:07 +0200
Subject: [PATCH 1/4] ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
In-Reply-To: <KL1PR06MB1702D289BE9642F285CF9ED1B84F0@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1507899796-7941-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <KL1PR06MB1702D289BE9642F285CF9ED1B84F0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Message-ID: <20171017075907.p2yr3tjq6nqx6uhb@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 08:34:35AM +0000, Biju Das wrote:
> Hi,
> 
> Looks like the chosen node "stdout-path = "serial0:115200n8";" is not updated with this patch.
> 
> So either drop the patch or fix the chosen node.

Please repost this patch with the above resolved.
