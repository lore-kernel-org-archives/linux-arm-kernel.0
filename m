From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 22 Apr 2013 09:01:10 +0200
Subject: [V3 patch 17/19] ARM: kirkwood: cpuidle: use init/exit common
 routine
In-Reply-To: <20130414151429.GF5061@lunn.ch>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org>
 <20130414151429.GF5061@lunn.ch>
Message-ID: <5174E036.9090808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2013 05:14 PM, Andrew Lunn wrote:

[ ... ]
>  int kirkwood_cpuidle_remove(struct platform_device *pdev)
>  {
> -	cpuidle_unregister_device(device);
> -	cpuidle_unregister_driver(&kirkwood_idle_driver);
> -
> +	cpuidle_unregister(&kirkwood_idle_driver);
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Hi Andrew,

shall I consider it as acked-by also ?

Thanks
  -- Daniel
