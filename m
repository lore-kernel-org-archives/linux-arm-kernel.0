From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 16:42:46 +0200
Subject: [GIT PULL] non urgent auxdata fix for v4.7 merge window
In-Reply-To: <20160504175306.GU5995@atomide.com>
References: <20160504175306.GU5995@atomide.com>
Message-ID: <6011894.DIQc11mCV6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 May 2016 10:53:07 Tony Lindgren wrote:
> Device tree auxdata handling fix that allows a match based on the
> compatible string if no exact match based on the IO address is found.
> 
> This leaves out the need to patch auxdata for each driver when adding
> new SoCs. And it also reprotedly fixes the issue of passing auxdata
> to a child if the parent instantiates the child from DT as discussed
> in the "[PATCH] of/platform: Allow secondary compatible match in
> of_dev_lookup" mailing list thread.
> 
> As a minimal use case, let's also convert omap pinctrl auxdatato
> use a generic match.
> 
> There is no need to get this in to the v4.6-rc cycle and it can wait
> for v4.7 merge window. Note that these changes have now been sitting
> in Linux next for about two weeks so far as I wanted to make sure no
> new issues are popping up.
> 
> 

Merged into next/fixes-non-critical, thanks!

	Arnd
