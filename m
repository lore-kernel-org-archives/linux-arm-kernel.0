From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 16 Jan 2017 11:32:40 +0100
Subject: [PATCH 2/4] clk: samsung: Remove Exynos4415 driver (SoC not
 supported anymore)
In-Reply-To: <20170114123642.15581-3-krzk@kernel.org>
References: <20170114123642.15581-1-krzk@kernel.org>
 <CGME20170114123727epcas2p296aae6459c8575d7e5def74f18e5c64d@epcas2p2.samsung.com>
 <20170114123642.15581-3-krzk@kernel.org>
Message-ID: <c9b51cb6-f798-d41e-afff-f779b963345c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2017 01:36 PM, Krzysztof Kozlowski wrote:
> Support for Exynos4415 is going away because there are no internal nor
> external users.
> 
> Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
> the platform cannot be instantiated so remove also the drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
