From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 16:04:14 +0200
Subject: [GIT PULL]arm64: dts: hisilicon: hi6220 updates for 4.8(#2)
In-Reply-To: <577E5E70.1050304@hisilicon.com>
References: <577E5E70.1050304@hisilicon.com>
Message-ID: <3758123.tusoMPnEKS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2016 2:51:44 PM CEST Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> I know the walkaround for this kind of patch is still under discussion.
> Could you please consider to pull the following changes?
> 
> This depends on the change in clk tree (clk-hi6220-rtc)
> which is already in the clk-next.
> 
> And for easier grepping through history, below is the pull request
> for the dts specific change (no clk commits):

Thanks for sending it now, that is helpful if we decide to pick it
up. I'd wait a few more days for the outcome of the discussion before
merging it though.

The patch obviously looks harmless enough, I'd just like to have a plan
for the next time we get this kind of dependency on hi6220.

	Arnd
