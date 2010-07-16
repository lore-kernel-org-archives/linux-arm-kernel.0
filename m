From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Jul 2010 09:58:45 +0100
Subject: [PATCH v2 5/5] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <1279267277-6804-6-git-send-email-myungjoo.ham@samsung.com>
References: <1279267277-6804-1-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-2-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-3-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-4-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-5-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-6-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100716085844.GC18376@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 05:01:17PM +0900, MyungJoo Ham wrote:
> S5PV210 CPUFREQ Support.
> 
> This CPUFREQ may work without PMIC's DVS support. However, it is not
> as effective without DVS support as supposed. AVS is not supported in
> this version.

Especially in terms of the regulator API usage:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
