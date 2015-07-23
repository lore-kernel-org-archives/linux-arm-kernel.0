From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Jul 2015 15:54:11 +0100
Subject: [PATCH v5 00/19] Per-device MSI domain & platform MSI
In-Reply-To: <20150723131832.GW21967@google.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <20150723131832.GW21967@google.com>
Message-ID: <55B10013.6070306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/15 14:18, Bjorn Helgaas wrote:
> On Thu, Jul 23, 2015 at 10:26:19AM +0100, Marc Zyngier wrote:
>> MSI-like interrupts are starting to creep out of the PCI world, and
>> can now be seen into a number of "platform"-type busses. The
>> introduction of the MSI domains feature in v3.19 recognised that fact,
>> and started providing a way to implement this.
>> ...
> 
> The PCI parts all look great to me.  I assume Thomas will merge the whole
> thing through his tree.  Thanks!

Thanks a lot for taking the time to review it. I'll respin the series
with your nits and acks :-).

	M.
-- 
Jazz is not dead. It just smells funny...
