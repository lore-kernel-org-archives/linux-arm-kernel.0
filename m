From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 01:55:32 +0100
Subject: [PATCHv2] SAMSUNG: Audio support
In-Reply-To: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
References: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20100519005532.GC4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 04:02:08PM +0900, Jassi Brar wrote:
> Hi,
>  Following are few patches to define and add audio devices' support
> for latest Samsung SoCs, namely S5P6440, S5P6442, S5PC100, S5PC110
> and S5PV210 on respective SMDK board.
>  The device drivers will be enabled to run these via ASoC tree.
> 
> Changes since v1:
> 	o Drop EXPORT_SYMBOL for platform device definitions

Merged everything bar the C100 support, would prefer to get the C100
move sorted out before piling more stuff in here.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
