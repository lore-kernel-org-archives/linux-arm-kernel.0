From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 5 Mar 2018 14:43:52 +0000
Subject: [PATCH v6 13/20] firmware: arm_scmi: refactor in preparation to
 support per-protocol channels
In-Reply-To: <20180305153549.00000f39@huawei.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-14-git-send-email-sudeep.holla@arm.com>
 <20180305153549.00000f39@huawei.com>
Message-ID: <1e824524-5ed3-dfbc-b2fb-6a15631b44cd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/03/18 14:35, Jonathan Cameron wrote:
> On Fri, 23 Feb 2018 16:23:43 +0000
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> In order to support per-protocol channels if available, we need to
>> factor out all the mailbox channel information(Tx/Rx payload and
>> channel handle) out of the main SCMI instance information structure.
>>
>> This patch refactors the existing channel information into a separate
>> chan_info structure.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> A little odd to present a series to mainline that does a fairly important
> refactor mid way through.  Why not push this down to the start and always support
> the separate chan_info structure?
> 

Since the development started long back and this was added later, I
preferred to keep functionality working and didn't want to push change
down in the stack.

-- 
Regards,
Sudeep
