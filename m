From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Dec 2011 00:50:51 +0000
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <20111221141907.GA1777@richard-laptop>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <20111221012046.GE15863@b20223-02.ap.freescale.net>
 <20111221092739.GI15863@b20223-02.ap.freescale.net>
 <201112210943.34310.arnd@arndb.de>
 <CAPXgP10FCrqdTg++46m4+xxM9tw1ZrKc8wz=JkKjCHJ0hQPtng@mail.gmail.com>
 <20111221121246.GB15309@opensource.wolfsonmicro.com>
 <CAPXgP10CGxfEJ4jK2MkKt0-nAWgiawDERyA1N4wHvMCJfE3oDg@mail.gmail.com>
 <20111221141907.GA1777@richard-laptop>
Message-ID: <20111222005048.GA27144@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 10:19:11PM +0800, Richard Zhao wrote:

> Even cpu node is device, I still need to find a way to get it.  I think it's
> better have another patch to fix the regulator dt binding in cpu node. I'll
> not include it in this patch series.

I'd expect this to be easy if we can find any device tree data for the
CPU at all?  It's just another piece of data no different to the clock
rates or whatever.
