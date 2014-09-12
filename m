From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Fri, 12 Sep 2014 21:03:55 +0100
Subject: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
In-Reply-To: <54134CE8.8070506@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
 <54134CE8.8070506@redhat.com>
Message-ID: <20140912200355.GD9234@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 03:43:36PM -0400, Jon Masters wrote:
> On 09/12/2014 10:00 AM, Hanjun Guo wrote:
> > From: Graeme Gregory <graeme.gregory@linaro.org>
> > 
> > ACPI 5.1 does not currently support S states for ARM64 hardware but
> > ACPI code will call acpi_target_system_state() for device power
> > managment, so introduce sleep-arm.c to allow other drivers to function
> > until S states are defined.
> 
> Aside: ACPI5.1 does define the Platform Communication Channel and CPC
> (Collaborative Processor Performance Control). Some details need to be
> fleshed out there for practical 64-bit ARMv8 server systems, but the
> underpinnings and mechanisms are in place in the 5.1 specification that
> can be built upon over time to achieve practical S-State equivalence.
> 
Disagree, S-States are about going to sleep or hibernating, that is
nothing to do with CPU Performance.

Graeme
