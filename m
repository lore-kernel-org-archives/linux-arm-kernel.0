From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 28 Aug 2012 11:51:52 +0530
Subject: [PATCH 2/2] arm/dts: Cleanup regulator naming and remove @0,1..
In-Reply-To: <20120824202725.GA1303@atomide.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
 <1343653940-16614-3-git-send-email-rnayak@ti.com>
 <20120824202725.GA1303@atomide.com>
Message-ID: <503C6380.4090107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

> * Rajendra Nayak<rnayak@ti.com>  [120730 06:17]:
>> regulators do not have a 'reg' property, hence the regulator at 0,
>> regulator at 1 do not make sense. get rid of it.
>
> Looks like this needs to be refreshed to apply. Care to
> refresh against current devel-dt branch in case other
> places need the same change?

Looks like devel-dt is missing the PATCH 1/2 from this series,
which you have already pushed in the -rc for merge.
With that applied, this ones applies cleanly too.

regards,
Rajendra

>
> Regards,
>
> Tony
