From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Mon, 24 Oct 2016 11:21:21 -0600
Subject: [PATCH V4 09/10] trace, ras: add ARM processor error trace event
In-Reply-To: <20161021163410.0a827eab@gandalf.local.home>
References: <1477071013-29563-1-git-send-email-tbaicar@codeaurora.org>
 <1477071013-29563-10-git-send-email-tbaicar@codeaurora.org>
 <20161021163410.0a827eab@gandalf.local.home>
Message-ID: <7a8c62a7-c2f4-0cae-ce0a-24cbf827bd4f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 2:34 PM, Steven Rostedt wrote:
> On Fri, 21 Oct 2016 11:30:12 -0600
> Tyler Baicar <tbaicar@codeaurora.org> wrote:
>
>> Currently there are trace events for the various RAS
>> errors with the exception of ARM processor type errors.
>> Add a new trace event for such errors so that the user
>> will know when they occur. These trace events are
>> consistent with the ARM processor error section type
>> defined in UEFI 2.6 spec section N.2.4.4.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Tracing part looks fine to me.
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve
Thank you Steve!

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
