From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 17:58:38 +0200
Subject: [GIT PULL 3/8] ARM: tegra: RAM code access for v4.2-rc1
In-Reply-To: <1431524980-13599-4-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-4-git-send-email-thierry.reding@gmail.com>
Message-ID: <2345639.Sj7e0cAmhK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 15:49:35 Thierry Reding wrote:
> Note that this is a shared dependency for the tegra-for-4.2-clk and the
> tegra-for-4.2-emc pull requests and they are already based on this, so
> it's sufficient if you pull those in individually.
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: RAM code access for v4.2-rc1
> 
> The RAM code is used by the memory and external memory controllers to
> determine which set of timings to use for memory frequency scaling.
> 

I've pulled it into next/drivers separately for documentation purposes,
even if it's not strictly necessary as you say. Thanks!

	Arnd
