From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 15 Apr 2016 15:08:25 +0900
Subject: [PATCH 2/7] PM / devfreq: exynos: Add the detailed correlation for
 Exynos5422 bus
In-Reply-To: <20160411154514.GA29936@rob-hp-laptop>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-3-git-send-email-cw00.choi@samsung.com>
 <20160411154514.GA29936@rob-hp-laptop>
Message-ID: <57108559.5010102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 2016? 04? 12? 00:45, Rob Herring wrote:
> On Fri, Apr 08, 2016 at 02:00:41PM +0900, Chanwoo Choi wrote:
>> This patch adds the detailed corrleation between sub-blocks and power line
>> for Exynos5422.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt        | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
> 
> This belongs with your previous series. Probably, all of this should be 
> 1 DT patch rather than piecemeal. Any division should be by h/w block, 
> not as a driver is using features.

On previous patch-set[1] didn't support the Exynos5420 and include any information
about Exynos542x SoC because Exynos5420 must need the specific device driver
which is NoC (Network On Chip) Probe device. Only this patch-set support
the NoC Probe device. So, I make this separate patch on this patch-set.

[1] http://www.spinics.net/lists/arm-kernel/msg495976.html
- [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor

Best Regards,
Chanwoo Choi
