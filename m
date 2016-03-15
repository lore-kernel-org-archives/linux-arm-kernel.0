From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 15 Mar 2016 16:30:45 +0100
Subject: [GIT PULL 1/3] 2nd part of rockchip soc-driver changes for 4.6
In-Reply-To: <2165258.7vUftGQ1I7@diego>
References: <2165258.7vUftGQ1I7@diego>
Message-ID: <4293420.gm3Wdi1Lsl@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please scrap these 3 pull requests. I'm migrating the commits to v4.7 in my 
tree.


Thanks
Heiko

Am Freitag, 4. M?rz 2016, 02:39:50 schrieb Heiko Stuebner:
> Hi Arnd, Olof, Kevin,
> 
> this contains a fix for the error handling of the power-domain driver.
> 
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit 1d961f11a108af9f7fbe89cc950a8d16ddbdbb28:
> 
>   soc: rockchip: power-domain: fix err handle while probing (2016-02-02
> 22:18:31 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
> tags/v4.6-rockchip-drivers2
> 
> for you to fetch changes up to 1503cfbbc7c62509c9b1188508d312ab9c90cb24:
> 
>   soc: rockchip: power-domain: check the existing of regmap (2016-02-15
> 22:24:14 +0100)
> 
> ----------------------------------------------------------------
> Fix handling the case when syscon_node_to_regmap returns an error
> in the power-domain driver.
> 
> ----------------------------------------------------------------
> Shawn Lin (1):
>       soc: rockchip: power-domain: check the existing of regmap
> 
>  drivers/soc/rockchip/pm_domains.c | 4 ++++
>  1 file changed, 4 insertions(+)
