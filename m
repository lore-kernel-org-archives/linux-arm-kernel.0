From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 11 Jun 2014 14:38:51 -0400 (EDT)
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.11.1406111431080.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jun 2014, Lorenzo Pieralisi wrote:

> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
> 
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.

Oh and another pet peeve of mine: given we always talk about "device 
tree" all the time, could you s/OF/DT/ in the subject?  It's been a 
while that DT has outgrown its OF origins.

>  create mode 100644 drivers/cpuidle/of_idle_states.c
>  create mode 100644 drivers/cpuidle/of_idle_states.h

Ditto here, including any new symbols you introduced.

Nicolas
