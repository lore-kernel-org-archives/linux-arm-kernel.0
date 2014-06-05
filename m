From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 16:22:46 +0100
Subject: [STLinux Kernel] [PATCH 3/6] thermal: sti: Add support for ST's
 System Config Register based Thermal controller
In-Reply-To: <20140605151650.GB7446@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
 <1401442715-6350-4-git-send-email-lee.jones@linaro.org>
 <20140605151650.GB7446@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140605152246.GC7446@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,


> Also a seperate somewhat unrelated question... stih415 and stih416 are very similar 
> dual die parts. Do you know why the stih415 has support for sas & mpe die temperature
> sensors, but the stih416 only has support for the sas die?

Ah I see...support for the stih416 mpe sensor is in a subsquent patch in the series.

regards,

Peter.
