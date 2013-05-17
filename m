From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 13:39:00 -0600
Subject: Naming convention DSI + device tree
In-Reply-To: <5195C1E2.4020009@nvidia.com>
References: <20130514181745.GA2762@mail.o2s.ch>
 <51940C22.4050802@wwwdotorg.org> <20130516071537.GA13573@mail.o2s.ch>
 <519522C1.5010107@wwwdotorg.org> <5195C1E2.4020009@nvidia.com>
Message-ID: <51968754.6050509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 11:36 PM, Alex Courbot wrote:
...
> I checked whether the rebase worked and it does - you just need to
> enable host1x/tegradrm support on top of the default settings (Stephen,
> why aren't these enabled by default?)

I guess it just got overlooked. I see CONFIG_DRM is on though; perhaps
the default for the Tegra DRM driver changed in Kconfig. Feel free to
send a patch to tegra_defconfig.
