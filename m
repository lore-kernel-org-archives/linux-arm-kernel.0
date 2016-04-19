From: bsingharora@gmail.com (Balbir Singh)
Date: Tue, 19 Apr 2016 21:32:47 +1000
Subject: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
References: <146105442758.18940.2792564159961963110.stgit@zurg>
Message-ID: <5716175F.9030001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/04/16 18:27, Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>

Acked-by: Balbir Singh <bsingharora@gmail.com>
