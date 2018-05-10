From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 10 May 2018 10:53:06 +0100
Subject: [PATCH 3/8] firmware: arm_scmi: rename get_transition_latency
 and add_opps_to_device
In-Reply-To: <CAJZ5v0ixZPB8aZs0xc9-3JMrWfRC7+7mzYWNaCj1o_q6VSqEJA@mail.gmail.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
 <1525885634-22348-4-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0ixZPB8aZs0xc9-3JMrWfRC7+7mzYWNaCj1o_q6VSqEJA@mail.gmail.com>
Message-ID: <20180510095306.GA24594@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 10:29:48AM +0200, Rafael J. Wysocki wrote:
> On Wed, May 9, 2018 at 7:07 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Most of the scmi code follows the suggestion from Greg KH on a totally
> > different thread[0] to have the subsystem name first, followed by the
> > noun and finally the verb with couple of these exceptions.
> >
> > This patch fixes them so that all the functions names are aligned to
> > on practice.
> >
> > [0] https://www.spinics.net/lists/arm-kernel/msg583673.html
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> ACK for the cpufreq driver changes and I'm assuming this to go in via the arch.
>

Thanks, yes I plan to send it via ARM-SoC.

--
Regards,
Sudeep
