From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Sep 2011 13:32:06 +0100
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs based
	on platform device name.
In-Reply-To: <1645899.rJz3R6pebo@flatron>
References: <1731819.jJi37IsjvJ@flatron>
	<001d01cc684e$9c49ecd0$d4ddc670$%kim@samsung.com>
	<CAH9JG2UiuaCyOk24hC=240ptQa8CKCVkXHaQzNt=YcnyQksnOA@mail.gmail.com>
	<1645899.rJz3R6pebo@flatron>
Message-ID: <20110901123205.GB2061@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 01:18:32PM +0200, Tomasz Figa wrote:
> On Thursday 01 of September 2011 at 12:33:10, Kyungmin Park wrote:

> Well, now we have three alternatives:
> - to leave it as is (i.e. changing platform device names)
> - to use cpu_is_* (does it ever exist for S3C64xx or soc_is_s3c64xx is its equivalent?)
> - to use soc_is_* 

soc_is is the same thing.
