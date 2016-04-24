From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 23:18:58 +0200
Subject: [GIT PULL 2/5] ARM: dts: exynos: DT for v4.7
In-Reply-To: <1460541682-32417-3-git-send-email-k.kozlowski@samsung.com>
References: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
 <1460541682-32417-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5773702.Vl2lnk0PfR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2016 12:01:19 Krzysztof Kozlowski wrote:
> Samsung Device Tree updates and improvements for v4.7:
> 1. Enable accelerated AES (Security SubSystem) on Exynos4412-based boards.
> 2. Enable HDMI CEC on Exynos4412-based Odroid.
> 3. Add regulator supplies for eMMC/SD on Odroid XU3/XU4.
> 4. Fix DTC unit name warnings.
> 5. Merge topic branch of new Artik5 board.
> 

Pulled into next/dt. Thanks for splitting this into a separate branch
aside from the Artik5 stuff, that makes sense. Two minor things you
could have done even better:

- split out the DTC unit name warning fixes into yet another branch,
  as there are lots of them and they are unrelated to the rest

- not merge the Artik5 changes into this, but let us deal with
  any conflicts ourselves.

	Arnd
