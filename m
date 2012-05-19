From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 20 May 2012 02:35:05 +0900
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle - declare the states with the
 new api
In-Reply-To: <20120517122802.GG26337@opensource.wolfsonmicro.com>
References: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
 <1337004377-17732-2-git-send-email-daniel.lezcano@linaro.org>
 <20120517122802.GG26337@opensource.wolfsonmicro.com>
Message-ID: <4FB7D9C9.1020004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/12 21:28, Mark Brown wrote:
> On Mon, May 14, 2012 at 04:06:16PM +0200, Daniel Lezcano wrote:
>> The states are now part of the cpuidle_driver structure, so we can
>> declare the states in this structure directly. That saves us an extra
>> variable declaration and a memcpy.
>
> Tested-by: Mark Brown<broonie@opensource.wolfsonmicro.com>

Thanks for testing, applied this series.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
