From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 1 Sep 2011 15:00:42 +0100
Subject: [PATCH v2 0/7] Initial Calxeda Highbank support
In-Reply-To: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110901140042.GE2585@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 08:43:59PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds initial platform support for Calxeda's Highbank ARM SOC including
> SMP, hotplug, and suspend support. One new patch to add empty version of
> l2x0_of_init. Changes for v2 are listed in each patch.
> 
> Based on rmk's for-next branch with gpio.h and io.h clean-ups plus previously
> posted GIC devicetree binding support. The GIC patches are here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060570.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060790.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062735.html

Nice series!

Reviewed-by: Jamie Iles <jamie@jamieiles.com>
