From: Zachary.Burke@digimarc.com (Burke, Zachary)
Date: Mon, 10 Sep 2012 17:48:44 +0000
Subject: Exynos 4xxx Camera Image Filtering
Message-ID: <7F1C005B6D42174DB9BF844CD0F55B9D257BF353@PDX-P-EX-C2A.corp.digimarc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have noticed that on the Exynos devices available to us (4412 and 4212 in the Galaxy Note 10.1 and Galaxy S3) that there appears to be noise reduction/filtering occurring somewhere in the image post-processing path.

TI does similar filtering on the omap4xxx chip but exposes image post-processing parameters to disable the noise suppression filter, these are defined in:
hardware/ti/omap4xxx/camera/TICameraParameters.cpp

I am looking for similar functionality on Exynos.  I've gone through the kernel source for the galaxy tab (GT-N8013_ICS_Opensource) but see no evidence of post-processing parameters in the camera driver.

* Can I disable noise filtering from user space?
* Can anyone point to a whitepaper or source that details the behavior of noise filtering on Exynos?

Regards
