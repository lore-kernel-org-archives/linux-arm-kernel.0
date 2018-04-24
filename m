From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 24 Apr 2018 11:10:46 +0200
Subject: [PATCH V2 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
In-Reply-To: <4ca19364ff10083c3912ce428207c3f713f973b9.1524549644.git.viresh.kumar@linaro.org>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
 <4ca19364ff10083c3912ce428207c3f713f973b9.1524549644.git.viresh.kumar@linaro.org>
Message-ID: <20180424111046.704637d3@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Tue, 24 Apr 2018 11:37:36 +0530, Viresh Kumar
<viresh.kumar@linaro.org> wrote:

> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Add suspend/resume hooks in Armada 37xx DVFS driver to handle S2RAM
> operations. As there is currently no 'driver' structure, create one
> to store both the regmap and the register values during suspend
> operation.
> 
> A syscore_ops is used to export the suspend/resume hooks.

I think you can remove this line too since there is no more syscore_ops.

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Regards,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
