From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 17 Feb 2013 12:22:38 +0800
Subject: [PATCH] ARM:kernel: a bug for perf by a redundancy character ';'
In-Reply-To: <51203BC9.60600@asianux.com>
References: <511F2C0D.4030206@asianux.com> <511F3D8C.6090603@gmail.com>
 <511F4574.7000707@asianux.com>
 <20130216122646.GA14174@mudshark.cambridge.arm.com>
 <51203BC9.60600@asianux.com>
Message-ID: <51205B0E.4000404@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  oh, sorry, the comments still use charactor.

  I will send pach v2.

gchen.

? 2013?02?17? 10:09, Chen Gang ??:
> 
>   delete the redundancy charactor ';', which will cause issue.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Acked-by: Dirk Behme <dirk.behme@gmail.com>
> ---
>  arch/arm/kernel/perf_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 31e0eb3..a892067 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -400,7 +400,7 @@ __hw_perf_event_init(struct perf_event *event)
>  	}
>  
>  	if (event->group_leader != event) {
> -		if (validate_group(event) != 0);
> +		if (validate_group(event) != 0)
>  			return -EINVAL;
>  	}
>  
> 


-- 
Chen Gang

Asianux Corporation
