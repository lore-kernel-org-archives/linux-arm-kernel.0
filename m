From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Wed, 19 Mar 2014 16:26:52 -0700
Subject: [PATCH v7 1/2] ARM: avoid tracers in soft_restart
In-Reply-To: <531908b6.44f8440a.03ab.0cce@mx.google.com>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-2-git-send-email-sebastian.capella@linaro.org>
 <531908b6.44f8440a.03ab.0cce@mx.google.com>
Message-ID: <CADHgK6ssL=0XcM_shGmb9z1T3w5L5OWEJgs-v9VyT3=USwY4FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2014 15:45, Sebastian Capella <sebastian.capella@linaro.org> wrote:
> Quoting Sebastian Capella (2014-03-05 02:50:04)
>> Use of tracers in local_irq_disable is causes recursive aborts when
>> called with irqs disabled and using a temporary stack (hibernation).
>> Replace local_irq_disable with raw_local_irq_disable instead to
>> avoid tracers.

> I have not heard any feedback on this change, since V3 of the
> patchset.
> Is everyone ok with this as it is?
> Thomas, thanks for proposing this, is this looking ok to you?

ping

I haven't received any further communication / acks on this particular
patch, since Russell's ~approval below:

On 26 February 2014 15:37, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Great, I'm happy with this now.  I assume that the plan is to submit this
>  to my patch system when everyone's given their fill of acks?

Is this ok as it is?

Thanks,

Sebastian
