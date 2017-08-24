From: horms@verge.net.au (Simon Horman)
Date: Thu, 24 Aug 2017 06:47:01 -0400
Subject: [PATCH v2] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <1502874990-12006-1-git-send-email-chris.paterson2@renesas.com>
References: <1502874990-12006-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20170824104701.GA30281@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 10:16:30AM +0100, Chris Paterson wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> Define the iWave RainboW-G20D-Qseven board dependent part of the
> RTC device node.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> [chris: corrected bq32000 compatible string]
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
> v1 -> v2
> Added ti to bq32000 compatible string - Thanks Geert

Thanks, applied for v4.15.
