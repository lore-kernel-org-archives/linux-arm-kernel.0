From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Mon, 29 Sep 2014 09:47:34 -0700
Subject: [PATCH v3 1/2] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <20140929083136.GG12506@ulmo> (Thierry Reding's message of "Mon,
 29 Sep 2014 10:31:37 +0200")
References: <1411874849-343-1-git-send-email-mitchelh@codeaurora.org>
 <1411874849-343-2-git-send-email-mitchelh@codeaurora.org>
 <20140929083136.GG12506@ulmo>
Message-ID: <vnkwmw9il6ft.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29 2014 at 01:31:37 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Sat, Sep 27, 2014 at 08:27:28PM -0700, Mitchel Humpherys wrote:
>> From: Matt Wagantall <mattw@codeaurora.org>
>> 
>> It is sometimes necessary to poll a memory-mapped register until its
>> value satisfies some condition. Introduce a family of convenience macros
>> that do this. Tight-loop and sleeping versions are provided with and
>> without timeouts.
>> 
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
>> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
>> ---
>>  include/linux/iopoll.h | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>  create mode 100644 include/linux/iopoll.h
>
> It would be good to provide a changelog with each new version of the
> patch. As it is I now have v2 and v3 of this patch in my inbox and I
> have no idea what the differences are, so I'd need to download both
> and run them through interdiff to find out.

Yeah I put the changelog in the cover letter.  There were no changes on
this patch, though I admit that wasn't entirely clear now re-reading the
cover letter text.  I also didn't account for the fact that you probably
aren't reading the whole series since I only Cc'd you on this patch, not
the whole series.  In any case, I probably shouldn't have re-sent the
whole series after one minor modification to one patch in the series.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
