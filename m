From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 11:45:33 -0700
Subject: [PATCH v2 3/3] ARM: OMAP2: delete board-rm680
In-Reply-To: <1380050897-6605-4-git-send-email-aaro.koskinen@iki.fi>
References: <1380050897-6605-1-git-send-email-aaro.koskinen@iki.fi>
 <1380050897-6605-4-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20131008184532.GL8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130924 12:36]:
> Delete board file for Nokia RM-680/RM-696 (N950/N9). DT-based booting
> should be used for further development on this HW.

I'll apply this into omap-for-v3.13/board-removal that I
will rebase on Benoit's .dts changes before I push out
that branch.

Regards,

Tony
