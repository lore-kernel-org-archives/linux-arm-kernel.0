From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 7 Jul 2015 13:13:39 +0200
Subject: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <E959C4978C3B6342920538CF579893F0025F34FC@SHSMSX104.ccr.corp.intel.com>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-4-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025F342B@SHSMSX104.ccr.corp.intel.com>
 <559BB167.1030603@redhat.com>
 <E959C4978C3B6342920538CF579893F0025F34FC@SHSMSX104.ccr.corp.intel.com>
Message-ID: <559BB463.6090406@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/07/2015 13:13, Wu, Feng wrote:
>> > You can use container_of to add it to your own struct, e.g.
>> > 
>> > 	struct irq_bypass_consumer cons;
>> > 	struct irq_bypass_producer *prod;
> Do you mean this:
> 
> struct kvm_kernel_irqfd {
> 	
> 	......
> 
> 	struct irq_bypass_consumer cons;
> 	struct irq_bypass_producer *prod;
> };

Yes.

Paolo
