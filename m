From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Mar 2016 22:25:12 +0200
Subject: [PATCH v4 5/8] arm64: dts: rockchip: Clean up gpio-keys nodes
In-Reply-To: <5487279.12FUefa44Q@diego>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <1458136727-32075-6-git-send-email-afaerber@suse.de>
 <5487279.12FUefa44Q@diego>
Message-ID: <5019372.31vzIfeZLF@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 28. M?rz 2016, 22:24:12 schrieb Heiko St?bner:
> Am Mittwoch, 16. M?rz 2016, 14:58:43 schrieb Andreas F?rber:
> > Drop superfluous #address-cells and #size-cells.
> > Use KEY_POWER define for 116.
> > Rename sub-nodes to avoid new dtc warnings.
> > 
> > Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> > Cc: Julien Chauveau <chauveau.julien@gmail.com>
> > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> applied to my dts64 branch for 4.6

4.7 of course


Heiko
