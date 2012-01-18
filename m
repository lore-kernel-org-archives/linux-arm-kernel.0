From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jan 2012 11:42:28 +0000
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <20120118113949.GA22977@sirena.org.uk>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
 <20120118113949.GA22977@sirena.org.uk>
Message-ID: <20120118114228.GB22977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 11:39:50AM +0000, Mark Brown wrote:

> This appears to reintroduce the setting of an exact voltage which I'm
> sure was fixed in previous versions of the patch.

Erk, sorry - it looks like the device tree list has quite a bit of lag
in moderation and sent out some old patches which I didn't notice.  All
this has been fixed in subsequent verisons.
