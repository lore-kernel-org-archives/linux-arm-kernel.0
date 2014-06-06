From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 6 Jun 2014 18:38:17 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAD=FV=WSEBRH-Py8oGXp0soAx_Y=j8NdoX89YiPGYeTBzQdOyw@mail.gmail.com>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <20140606203721.GA10422@quad.lixom.net>
 <CAM4voanSpTd=dAXLZhdZKRP4Z_YShbD4Hr-6UWn3DFYueoxeTA@mail.gmail.com>
 <20140606210126.GA10219@quad.lixom.net>
 <alpine.LFD.2.11.1406061717520.25775@knanqh.ubzr>
 <20140606214921.GA10969@quad.lixom.net>
 <CAD=FV=WSEBRH-Py8oGXp0soAx_Y=j8NdoX89YiPGYeTBzQdOyw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1406061836130.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jun 2014, Doug Anderson wrote:

> Note that handling CPU resume in a way that can be updated by RW
> firmware is non-trivial and requires some SRAM to be saved across
> suspend/resume.

Saved by the kernel or the firmware?


Nicolas
