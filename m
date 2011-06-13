From: Mark.Rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2011 14:48:05 +0100
Subject: [PATCH 3/4] ARM: pmu: add OF probing support
In-Reply-To: <4DF6134B.3090307@gmail.com>
References: <4DEFA5E1.9010600@gmail.com>
	<1307957757-23001-4-git-send-email-mark.rutland@arm.com>
	<4DF6134B.3090307@gmail.com>
Message-ID: <B393A6715F47FC43935D96EA15105EFF15CF24E41C@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robherring2 at gmail.com]
> Sent: 13 June 2011 14:40
> To: Mark Rutland
> Cc: linux-arm-kernel at lists.infradead.org; Jamie Iles; Will Deacon
> Subject: Re: [PATCH 3/4] ARM: pmu: add OF probing support
>
> Mark,
>
> On 06/13/2011 04:35 AM, Mark Rutland wrote:
> > This is based on an earlier patch from Rob Herring
> <rob.herring@calxeda.com>
> >
> >> Add OF match table to enable OF style driver binding. The dts entry
> is like
> >> this:
> >>
> >> pmu {
> >>    compatible = "arm,cortex-a9-pmu";
> >>    interrupts = <100 101>;
> >> };
> >>
> >> The use of pdev->id as an index breaks with OF device binding, so
> set the type
> >> based on the OF compatible string.
> >
> > This modification sets the PMU hardware type based on data embedded
> in the
> > binding, allowing easy addition of new PMU types in future.
> >
> > Support for new PMU types not provided by devicetree can be added
> later using
> > platform_device_id tables in a similar fashion.
> >
> > Cc: Jamie Iles <jamie@jamieiles.com>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >
> >  Rob: would you be happy to merge this into your tree? or would you
> >  rather I sent it through Russell?
>
> Looks good to me. I'm happy for you to take it.
>
> Rob

Thanks. Mind if I add your Ack?

Mark.

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
