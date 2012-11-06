From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 6 Nov 2012 07:19:26 +0000
Subject: [PATCH 04/15] ARM: OMAP2+: hwmod: Update the reset API for AM33XX
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB635A4@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-5-git-send-email-vaibhav.bedia@ti.com>
 <5097639C.7000800@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
 <79CD15C6BA57404B839C016229A409A83EB635A4@DBDE01.ent.ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04552@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 11:36:20, Hiremath, Vaibhav wrote:
[...]

> 
> The code is checking whether the line is already de-asserted (== 0), so I am 
> not sure how this will change if hardreset line is asserted during bootup.

You are right. I just checked the behavior since I recall seeing something odd
earlier. Looks like this is needed to avoid issues with subsequent hardreset
deassertions so I'll put it back in.

Regards.
Vaibhav
