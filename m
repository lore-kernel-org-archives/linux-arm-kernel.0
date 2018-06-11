From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 11 Jun 2018 17:39:38 +0300
Subject: [PATCH v6 0/5] Reintroduce i.MX EPIT Timer
In-Reply-To: <20180607140544.22268-1-peron.clem@gmail.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
Message-ID: <74959a6a-60bb-f854-6ef2-21c3c60d3451@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cl?ment,

On 06/07/2018 05:05 PM, Cl?ment P?ron wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>
> 
> As suggested in the commit message we have added the device tree support,
> proper bindings and we moved the driver into the correct folder.
> 
> Moreover we made some changes like use of relaxed IO accesor,
> implement sched_clock, delay_timer and reduce the clockevents min_delta.
> 

I reviewed and tested the driver on i.MX31, as expected it works fine,
and I'll give my tags per a commit, please add them to v7 changes.

--
Best wishes,
Vladimir
