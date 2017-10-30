From: rdunlap@infradead.org (Randy Dunlap)
Date: Sun, 29 Oct 2017 20:43:33 -0700
Subject: [PATCH V4 07/12] boot_constraint: Add debugfs support
In-Reply-To: <20171030033738.GG4240@vireshk-i7>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <a796de9a338d7d0876faa3ec99f5cb49315c893c.1509284255.git.viresh.kumar@linaro.org>
 <a553696c-0963-aab0-5750-467a9a42696d@infradead.org>
 <20171030033738.GG4240@vireshk-i7>
Message-ID: <d5d99527-bba3-d932-a29a-91a5e7c1a142@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/17 20:37, Viresh Kumar wrote:
> On 29-10-17, 08:09, Randy Dunlap wrote:
>> On 10/29/17 06:48, Viresh Kumar wrote:
>>> This patch adds debugfs support for boot constraints. This is how it
>>> looks for a "vmmc-supply" constraint for the MMC device.
>>>
>>> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  drivers/boot_constraints/clk.c    |  3 ++
>>>  drivers/boot_constraints/core.c   | 60 +++++++++++++++++++++++++++++++++++++++
>>>  drivers/boot_constraints/core.h   |  6 ++++
>>>  drivers/boot_constraints/pm.c     | 11 +++++--
>>>  drivers/boot_constraints/supply.c |  9 ++++++
>>>  5 files changed, 87 insertions(+), 2 deletions(-)
>>
>> Hi,
>> Does this build OK when CONFIG_DEBUG_FS is not enabled?
>>
>> I didn't see any depends on or select DEBUG_FS or any use of
>> CONFIG_DEBUG_FS in any Makefile.
> 
> As soon as I saw your reply, it looked like I have seen this email
> earlier. :)
> 
> https://marc.info/?l=linux-kernel&m=149866480929111&w=2
> 
> And yes, it builds just fine as all the dummy helpers are in place.
> 

Thanks.

-- 
~Randy
