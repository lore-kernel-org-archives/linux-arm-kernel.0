From: slash.tmp@free.fr (Mason)
Date: Tue, 22 Dec 2015 21:23:59 +0100
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <7hr3iexp3e.fsf@deeprootsystems.com>
References: <566FDF53.3030004@sigmadesigns.com>
 <7hr3iexp3e.fsf@deeprootsystems.com>
Message-ID: <5679B15F.80106@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/2015 20:25, Kevin Hilman wrote:

> Marc Gonzalez wrote:
> 
>> Changes since v10:
>> Add aliases and chosen DT nodes
>> Use CPU_CLK and SYS_CLK symbolic names
>> MPCore private memory region DT node
>> select TANGO_IRQ instead of GENERIC_IRQ_CHIP
>>
>> Changes planned for a future patch series:
>> Have clkgen driver export CD2 for USB, and CD6 for SDIO
> 
> Was it intentional to leave out a multi_v7_defconfig change so that this
> actually builds?  Or was that planned for a future series?

How is a multi_v7_defconfig different from any old defconfig?

> IMO, it should be part of this series so it gets build tested as soon as
> it's merged.

The problem is that a mandatory driver is missing upstream
(interrupt controller).

http://thread.gmane.org/gmane.linux.kernel/2089470

> Otherwise, looking good to me.
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

Woot! I already have the next patch series mostly ready, but I suppose
I should wait for this one to be accepted before submitting a new one.

Regards.
