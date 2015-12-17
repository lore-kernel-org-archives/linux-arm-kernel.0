From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 17 Dec 2015 12:09:28 -0800
Subject: [PATCH v3 0/5] Fix a trivial typo and support rk3228/rk3399 SoCs
 for thermal driver.
In-Reply-To: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20151217200927.GC7999@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 03, 2015 at 04:48:38PM +0800, Caesar Wang wrote:
> This series pacthes to support the next soc for this thermal driver.
> I don't add the dts thermal data since these SoCs have *_not_* land
> in this mainline. I believe these SoCs dts will land in this mainline
> lately,
> then I will add the thermal data for Heiko.
> 
> This series patches can apply into Eduardo branch.
> https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git
> 
> Also, this series pacthes have built on github branch.
> https://github.com/rockchip-linux/kernel/commits/develop4.4
> 
> PATCH[1/5]:
> That's bit ugly typo, sorry for sending again :(.
> 
> PATCH[2/5]:
> To fix a build warning came from Dan Carpenter report smatch check,
> Thanks. :)
> 
> PATCH[3/5]:
> Add the rk3228/rk3399 SoCs compatible for dt-bindings.
> 
> PATCH[4/5]:
> Add the rk3228 SoCs for thermal driver.
> 
> PATCH[5/5]:
> Add the rk3399 SoCs for thermal driver based on PATCH[4/5].

I applied all but 2/5.
