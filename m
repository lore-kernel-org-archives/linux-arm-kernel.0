From: tony@atomide.com (Tony Lindgren)
Date: Fri, 27 May 2016 09:35:09 -0700
Subject: [PATCH v4 2/7] ARM: dts: omap3: Add clocks to McBSP nodes
In-Reply-To: <1464185756-28401-3-git-send-email-peter.ujfalusi@ti.com>
References: <1464185756-28401-1-git-send-email-peter.ujfalusi@ti.com>
 <1464185756-28401-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160527163508.GZ5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160525 07:20]:
> Add clock properties to the McBSP nodes. McBSP2 and 3 need to have ick also
> since the Sidetone block of these modules are operating using the McBSP
> interface clock.

Can you please apply this dts patch as the first patch in the
series? That way I can merge it separately into my dts patches.

If no more comments other than the patch ordering change, when
v4.17-rc1 is out, please do an immutable branch against v4.17-rc1
and a pull request for me. Then that branch can be merged into
other trees as needed too.

Regards,

Tony
