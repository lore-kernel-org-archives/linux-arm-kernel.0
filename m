From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Apr 2011 11:01:59 -0700 (PDT)
Subject: [PATCH v4] ARM: Use generic BUG() handler
In-Reply-To: <BANLkTin_TpzdQS96SPKUNye6vb2b55Qc4A@mail.gmail.com>
References: <1302822031-6752-1-git-send-email-sjg@chromium.org>
	<4DA7A914.5020804@codeaurora.org>
	<BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
	<BANLkTin_TpzdQS96SPKUNye6vb2b55Qc4A@mail.gmail.com>
Message-ID: <143ea9b1bb96e613d534caa7cb3a1e2d.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, Apr 20, 2011 at 8:10 AM, Simon Glass <sjg@chromium.org> wrote:
>
>> On Thu, Apr 14, 2011 at 7:10 PM, Stephen Boyd <sboyd@codeaurora.org>
>> wrote:
>> > On 04/14/2011 04:00 PM, Simon Glass wrote:
>> >> From: Simon Glass <sjg@google.com>
>> >>
>> >> ARM uses its own BUG() handler which makes its output slightly
>> different
>> >> from other archtectures.
>>
>>
>> >> Signed-off-by: Simon Glass <sjg@chromium.org>
>> >
>> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>>
>> Thanks Stephen. Since there were no other comments I have submitted
>> this to RMK's patch tracking system.
>>
>
> Will this be part of linux kernel as i am not aware of patch tracking
> system? I want to back port this feature on my
> board which has Linux 2.6.35.7 kernel version(android gingerbread).
>

It's here:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6885/1

I imagine it will be added when/if Russell picks it up. Sadly it
increases the LOC in ARM so Simon might need to really
sell it to get it merged.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
