From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 4 May 2018 09:40:25 +0200
Subject: [RFC PATCH] ARM: dts: imx: replace underscore with hyphen in
 aliases name
In-Reply-To: <1525399128-11587-1-git-send-email-shawnguo@kernel.org>
References: <1525399128-11587-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20180504074025.GA11186@g751.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, May 04, 2018 at 09:58:48AM +0800, Shawn Guo wrote:
> It replaces underscore with hyphen in aliases name to fix DTC
> alias_paths warning below, which is seen with various i.MX board dts
> files when W=1 switch is on.
> 
>  Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> 
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Hi Lothar, Gary,
> 
> Per my search on kernel code, this change will not break anything on
> kernel support.  But I'm not really sure about the case of bootloaders
> running on the boards.  That's why I'm sending it as RFC.
> 
> We really want i.MX to be the first-class citizen in the community.
> After a few cycles efforts on cleaning up DTC warnings, this alias_paths
> warning is the last one we see with i.MX dts files.  We really want to
> get rid of it and make i.MX dts be DTC warning free.
> 
> So please comment whether we can merge this patch.

Yes that is fine.
Reviewed-by: Gary Bisson <gary.bisson@boundarydevices.com>

Thanks,
Gary
