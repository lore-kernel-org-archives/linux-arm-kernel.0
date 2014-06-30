From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Jun 2014 16:50:10 +0100
Subject: [PATCH v6 00/21] arm64: GICv3 support
In-Reply-To: <20140630154337.GR23978@titan.lakedaemon.net>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
 <20140630154337.GR23978@titan.lakedaemon.net>
Message-ID: <53B18732.4070509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 30/06/14 16:43, Jason Cooper wrote:
> Marc,
> 
> On Mon, Jun 30, 2014 at 04:01:29PM +0100, Marc Zyngier wrote:
>> I now have received enough Reviewed-by from people familiar with the
>> architecture, and a number of Tested-by from actual implementors,
>> which (IMHO) makes ready for merging into 3.17 (Thomas, Jason: How do
>> you want to play it? We have a rather big dependency between the first
>> few patches and the rest of the stuff, which is KVM only).
> 
> On a quick glance, it looks like patch #1 is conflict-prone and #2 crosses
> outside of irqchip/.  So, I could setup a topic branch for #1 that
> we'll both use.  Then I'll Ack #2 for you to take.  Would that work for
> you?

That'd be absolutely great. Just point me to the topic branch you'd like
to use, and I'll get it into the KVM/ARM tree.

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
