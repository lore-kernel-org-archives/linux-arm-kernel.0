From: vkale@apm.com (Vinayak Kale)
Date: Fri, 22 Nov 2013 12:15:10 +0530
Subject: [PATCH V4 1/2] genirq: Add an accessor for IRQ_PER_CPU flag
In-Reply-To: <528EAB34.6010105@codeaurora.org>
References: <1384946021-22100-1-git-send-email-vkale@apm.com>
 <1384946021-22100-2-git-send-email-vkale@apm.com>
 <528CFC77.5050200@codeaurora.org>
 <CAPrCYkefGMfweREk8bBKsO2VY4Tnc-fUZW8sw_K5ugRj5zJUFA@mail.gmail.com>
 <CAPrCYkdpHPPY6D1dj5R=QJ5mtmKUfTx+M7wRMV-t2LrZMdSW9w@mail.gmail.com>
 <528EAB34.6010105@codeaurora.org>
Message-ID: <CAPrCYkcrtDXQxCn-CY7UnX3etL7FHu-H2P-NGe+WFh6-=_2czQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 6:24 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 11/20/13 22:10, Vinayak Kale wrote:
>> [removing chris.smith at st.com]
>>
>> On Thu, Nov 21, 2013 at 11:36 AM, Vinayak Kale <vkale@apm.com> wrote:
>>> On Wed, Nov 20, 2013 at 11:46 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>>> On 11/20/13 03:13, Vinayak Kale wrote:
>>>>> This patch adds an accessor function for IRQ_PER_CPU flag.
>>>>> The accessor function is useful to dertermine whether an IRQ is percpu or not.
>>>>>
>>>>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>>>>> ---
>>>> This looks like a copy of Chris Smith's patch. Shouldn't Chris be the
>>>> author and the commit text be whatever Chris sent?
>>> In the cover letter of this patch series I did mention about Chris's
>>> earlier patch. I didn't know his email-id earlier, have found the
>>> mail-id now. CCing the mail-id to check whether it's still valid.
>>>
>> Chris's mail-id doesn't seem to be valid, the earlier mail to his
>> mail-id [chris.smith at st.com] bounced.
>> Please let me know in such case how to mention original author's credits.
>
> It's up to the maintainer accepting the patch. If I was picking up the
> patch I would say it doesn't really matter if the mail-id is valid
> anymore. Leave the original patch intact and just add your sign-off. If
> you took the patch and significantly changed it it's good to put
> "Based-on-a-patch-by:" and then take over authorship.
>
Thanks for the info.

I have made a minor change w.r.t. Chris's original patch: changed the
accessor function name from irq_is_per_cpu() to irq_is_percpu() since
I think irq_is_percpu() name is more inline with other *percpu* kernel
functions.

I will put Chris's sign-off as well as mine. I hope tglx will be fine with this.
