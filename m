From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Wed, 19 Mar 2014 15:21:07 +0100
Subject: [PATCH 13/16] avr32: update defconfig to use the generic PWM
 framework
In-Reply-To: <1395234209-15546-14-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-14-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140319142107.GE20872@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Wed 19 Mar 2014 14:03:26 +0100 or thereabout, Alexandre Belloni wrote:
> Now that all boards have switch to the generic PWM framework, update the
> defconfigs to use it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/configs/atngw100_mrmt_defconfig | 5 +++--
>  arch/avr32/configs/atstk1002_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1003_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1004_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1006_defconfig     | 5 +++--
>  arch/avr32/configs/merisc_defconfig        | 5 +++--
>  6 files changed, 18 insertions(+), 12 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
