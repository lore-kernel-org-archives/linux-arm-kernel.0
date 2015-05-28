From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 12:15:51 +0200
Subject: [PATCHv2] bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()
In-Reply-To: <5566EA8E.1020905@free-electrons.com>
References: <1432806054-17128-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <5566EA8E.1020905@free-electrons.com>
Message-ID: <2253455.mai05VvJcX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 May 2015 12:14:38 Gregory CLEMENT wrote:
> this patch depend on the previous one to apply. However the previous one
> is in the branch mvebu/fixes and this one will be in mvebu/drivers. How
> I should handle it?
> 
> Currently I applied the previous patch on the mvebu/drivers.

Please merge the mvebu/fixes branch into mvebu/drivers and apply it on
top of the merge.

	Arnd
