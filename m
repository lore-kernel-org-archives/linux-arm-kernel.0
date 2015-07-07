From: feng.wu@intel.com (Wu, Feng)
Date: Tue, 7 Jul 2015 11:24:08 +0000
Subject: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <559BB642.5010701@redhat.com>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-4-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025F342B@SHSMSX104.ccr.corp.intel.com>
 <559BB167.1030603@redhat.com>
 <E959C4978C3B6342920538CF579893F0025F34FC@SHSMSX104.ccr.corp.intel.com>
 <559BB463.6090406@redhat.com>
 <E959C4978C3B6342920538CF579893F0025F3568@SHSMSX104.ccr.corp.intel.com>
 <559BB642.5010701@redhat.com>
Message-ID: <E959C4978C3B6342920538CF579893F0025F35E1@SHSMSX104.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini at redhat.com]
> Sent: Tuesday, July 07, 2015 7:22 PM
> To: Wu, Feng; Eric Auger; eric.auger at st.com;
> linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org; christoffer.dall at linaro.org; marc.zyngier at arm.com;
> alex.williamson at redhat.com; avi.kivity at gmail.com; mtosatti at redhat.com;
> joro at 8bytes.org; b.reynal at virtualopensystems.com
> Cc: linux-kernel at vger.kernel.org; patches at linaro.org
> Subject: Re: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
> control
> 
> 
> 
> On 07/07/2015 13:18, Wu, Feng wrote:
> > Then I still need assign prod and de-assign prod in
> > irq_bypass_register_consumer/irq_bypass_unregister_consumer, Right?
> > Would you please share why this is better.
> 
> The need to store the consumer->producer link seems to be unique to
> posted interrupts.  It is difficult to say without seeing the PI code,
> but I prefer to keep the bypass manager as small as possible.

Fine. I will follow your suggestion!

Thanks,
Feng

> 
> Paolo
