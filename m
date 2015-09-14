From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 14 Sep 2015 17:03:16 +0100
Subject: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
In-Reply-To: <20150914151540.GI7002@leverpostej> (Mark Rutland's message of
 "Mon, 14 Sep 2015 16:15:40 +0100")
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
 <20150914131448.GC7002@leverpostej>
 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
 <20150914134949.GE7002@leverpostej>
 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
 <20150914144330.GH7002@leverpostej>
 <9hhfv2hdozu.fsf@e105922-lin.cambridge.arm.com>
 <20150914151540.GI7002@leverpostej>
Message-ID: <9hh7fntdm4b.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Sep 14, 2015 at 04:01:09PM +0100, Punit Agrawal wrote:
>> Mark Rutland <mark.rutland@arm.com> writes:
>> 

[...]

>> 
>> After seeing the mapping already published, I am wondering if there is
>> any value in duplicating the information. If there are no objections,
>> I'll update this patch to add pointers instead.
>
> That's fine by me. The important part is that the value is a raw Sensor
> ID as the FW uses. So long as we state that, the IDs themselves can come
> from whatever documentation is valid for a particular instance.
>
> Thanks for the info!

Sure. I've updated the patch to explain what the valid cell values are
along with a pointer to platform documentation for Juno R0 and R1.

I've also added an example to show usage of the sensors to create a
thermal zone.

I'll post a new version shortly.

Thanks for your having a look.

>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
