From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 18:46:18 +0100
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <20131219164624.GV2609@titan.lakedaemon.net> (Jason Cooper's
 message of "Thu, 19 Dec 2013 11:46:24 -0500")
References: <87siton6ke.fsf@natisbad.org>
 <20131219164624.GV2609@titan.lakedaemon.net>
Message-ID: <87sitoka39.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Cooper <jason@lakedaemon.net> writes:

> On Thu, Dec 19, 2013 at 05:34:09PM +0100, Arnaud Ebalard wrote:
>> I have a very simple driver (support for reading and setting the time)
>> for a RTC chip (Intersil ISL 12057) but cannot find anyone to get it
>> Acked and queued for v3.14. In v3.14, there should be at least three
>> users of the driver (ReadyNAS 102, 104 and 2120) if I meet -rc5 cutoff
>> for associated .dts changes.
>
> The -rc5 cutoff isn't a hard line.  It's also mvebu-specific.  eg, We
> need things _posted_ a week or so before arm-soc's cutoff of -rc6 so we
> have time to get the pull request in.  If it needs to go through
> mvebu/arm-soc, once it's posted, you're good.

I understand. But I guess you will not (for valid reason) accept .dts
changes to reference a rtc driver that is not on good track towards
-next. This is the issue I try and solve.


>> I never heard of *listed* RTC maintainer during all the review process
>> on rtc-linux list (v0 sent in october); I dug the list archives and when
>> this previously happened, someone else (e.g. Andrew Morton) was kind
>> enough to handle the patches:
>> 
>>   http://www.spinics.net/lists/arm-kernel/msg292187.html
>
> Unfortunately, it doesn't look like Alessandro has been active for a
> while and Andrew Morton has indeed been picking up the slack.  S-o-B's
> confirm this.
>
> I haven't worked with Andrew enough to know his workflow, but I imagine
> he can take patches much closer to the merge window than we can.
>
>> I wonder if someone (Andrew? Stephen? Jason?) would be kind enough to
>> take care of the v6 I just sent [1].
>
> I don't mind routing it though mvebu/arm-soc since the only consumers
> are currently mvebu boards, but I'd like to hear from Andrew that this
> is ok.

I will do what you think is the best.

Cheers,

a+
