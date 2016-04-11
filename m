From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Apr 2016 10:45:14 -0500
Subject: [PATCH 2/7] PM / devfreq: exynos: Add the detailed correlation
 for Exynos5422 bus
In-Reply-To: <1460091646-28701-3-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160411154514.GA29936@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 02:00:41PM +0900, Chanwoo Choi wrote:
> This patch adds the detailed corrleation between sub-blocks and power line
> for Exynos5422.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

This belongs with your previous series. Probably, all of this should be 
1 DT patch rather than piecemeal. Any division should be by h/w block, 
not as a driver is using features.

Rob
