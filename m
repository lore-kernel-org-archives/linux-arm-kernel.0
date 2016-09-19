From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 17:46:21 +0200
Subject: [GIT PULL 2/3] ARM: dts: exynos: DT for v4.9, second round
In-Reply-To: <1474216788-17282-3-git-send-email-krzk@kernel.org>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
 <1474216788-17282-3-git-send-email-krzk@kernel.org>
Message-ID: <4051277.uyRH9KkCtQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, September 18, 2016 6:39:47 PM CEST Krzysztof Kozlowski wrote:
> Samsung DeviceTree update for v4.9, second round:
> 1. Enable HDMI on Arndale Octa board.
> 2. Update list of clocks for FIMC-IS block on Exynos4x12.
> 3. Remove skeleton.dtsi thus fixing DT compiler warning:
>         "Node /memory has a reg or ranges property, but no unit name"
>    This is a tree-wide effort by various people. Javier Martinez Canillas did
>    it for Exynos and S5PV210.
> 

Pulled into next/dt, thanks!

	Arnd
