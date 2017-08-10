From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 11 Aug 2017 01:13:41 +0200
Subject: [PATCH 0/2] add cpufreq support to MT7622
In-Reply-To: <cover.1502272372.git.sean.wang@mediatek.com>
References: <cover.1502272372.git.sean.wang@mediatek.com>
Message-ID: <38532456.kVN5V9NzkU@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 9, 2017 12:12:37 PM CEST sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add cpufreq support to MT7622 SoC and also include some cleanups
> with the generic naming to explicitly support all MediaTek SoCs.
> 
> Sean Wang (2):
>   cpufreq: mediatek: add cleanups with the more generic naming
>   cpufreq: mediatek: add support of cpufreq to MT7622 SoC
> 
>  drivers/cpufreq/mediatek-cpufreq.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> 

Applied with ACKs from Viresh, thanks!
