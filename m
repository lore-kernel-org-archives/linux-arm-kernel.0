From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 8 Mar 2016 10:30:33 -0300
Subject: [PATCH 0/3] thermal: exynos: Fixes for vtmu-supply regulator
 handling
In-Reply-To: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Message-ID: <56DED3F9.8050505@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lukasz, Eduardo,

On 02/18/2016 03:19 PM, Javier Martinez Canillas wrote:
> Hello,
> 
> On a recent patch series to build a PMIC chip as a module [0], Krzysztof
> asked me to check if all the consumer drivers, using the resources that
> this PMIC provides, already support probe deferral.
> 
> While investigating that, I noticed that the Exynos TMU didn't do it so
> this series fix that bug and other two minor issues that I noticed while
> reviewing the driver and its DT binding.
> 
> The series are on top of Krzysztof's patches [1,2,3] not because there's
> a dependency but to avoid merge conflicts with in-flight patches. Please
> let me know if you prefer to use a different base instead.
> 
> [0]: https://lkml.org/lkml/2016/2/11/857
> [1]: https://patchwork.kernel.org/patch/8345791/
> [2]: https://patchwork.kernel.org/patch/8345741/
> [3]: https://patchwork.kernel.org/patch/8345701/
> 
> Best regards,
> Javier
> 

Any comments about this series?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
