From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:31:41 -0800
Subject: [GIT PULL 1/3] Rockchip driver changes for 4.10
In-Reply-To: <1698724.ZQnZMjf8xY@phil>
References: <1698724.ZQnZMjf8xY@phil>
Message-ID: <20161118073141.GI1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 04:34:17PM +0100, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below and in the following two mails, Rockchip power-domain as
> well as dts32 and dts64 changes for 4.10.
> 
> I don't think anything big stands out, just the usual mix of incremental
> improvements, so if stuff looks ok please pull.
> 
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.10-rockchip-drivers1
> 
> for you to fetch changes up to dabc0259db63338f0e64107cc92b2241f98a3284:
> 
>   soc: rockchip: power-domain: Handle errors from of_genpd_add_provider_onecell (2016-11-11 02:14:59 +0100)
> 
> ----------------------------------------------------------------
> Changes to the power-domain driver including counter presets now being set
> by firmware on the rk3399, avoiding infite loops when powering on/off a
> domain and actually returning an error if power-domain addition fails.
> The last part requires usage of the (new in 4.9-rc1) pm_genpd_remove
> functionality as well.

Merged, thanks!


-Olof
