From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 14 May 2012 01:51:00 +0200
Subject: [PATCH 0/2] ARM: S3C64xx: cpuidle cleanups
In-Reply-To: <1336572489-21457-1-git-send-email-daniel.lezcano@linaro.org>
References: <1336572489-21457-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4FB048E4.8070405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2012 04:08 PM, Daniel Lezcano wrote:
> These couple of patches use the new cpuidle core api to refactor
> some part of the code. The first one declares the states directly
> in the driver declaration and the second one use the timekeeping
> flag to let the cpuidle core to compute the idle time.
>
> I don't have this board, I was not able to test these patches.
>
> Daniel Lezcano (2):
>    ARM: s3c64xx: cpuidle - declare the states with the new api
>    ARM: s3c64xx: cpuidle - use timekeeping wrapper
>

Are these patches ok for inclusion ?

Thanks
-- Daniel


-- 
  <http://www.linaro.org/>  Linaro.org ? Open source software for ARM SoCs

Follow Linaro:<http://www.facebook.com/pages/Linaro>  Facebook |
<http://twitter.com/#!/linaroorg>  Twitter |
<http://www.linaro.org/linaro-blog/>  Blog
