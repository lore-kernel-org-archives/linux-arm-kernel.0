From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 4 Dec 2013 19:22:15 +0800
Subject: [PATCH RESEND] arm: pxa: tosa: fix keys mapping
In-Reply-To: <CALT56yOnv+2ohsiHtQ1a-jwEjo3H9fZ7hpehHfQCGHydHc6vSw@mail.gmail.com>
References: <20131116124750.GA26318@anuminas.rup.mentorg.com>
 <CALT56yOcUChApUP6rOyXqWuK55ZR0Ooj457XVP2b7bVR9yk-8A@mail.gmail.com>
 <528C2910.8030705@gmail.com>
 <CALT56yOnv+2ohsiHtQ1a-jwEjo3H9fZ7hpehHfQCGHydHc6vSw@mail.gmail.com>
Message-ID: <CAN1soZykH7A+Me-riXyhy2JKXhr=CcUNmCOaU22c8n7Nn7OauQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 9:12 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello Haojian,
>
> On Wed, Nov 20, 2013 at 7:14 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On 11/19/2013 04:33 PM, Dmitry Eremin-Solenikov wrote:
>>>
>>> Hello,
>>>
>>> On Sat, Nov 16, 2013 at 4:47 PM, Dmitry Eremin-Solenikov
>>> <dbaryshkov@gmail.com> wrote:
>>>>
>>>> When converting from tosa-keyboard driver to matrix keyboard, tosa keys
>>>> received extra 1 column shift. Replace that with correct values to make
>>>> keyboard work again.
>>>>
>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>> ---
>>>>   arch/arm/mach-pxa/tosa.c | 102
>>>> +++++++++++++++++++++++------------------------
>>>>   1 file changed, 51 insertions(+), 51 deletions(-)
>>>
>>>
>>> As nobody seems to object, I would like to use my tosa maintainer
>>> powers and push
>>> this patch for inclusion.
>>>
>>> Both Eric and Haojian seem to be unresponsive now.
>>> Russell, can I push it to your patch system? Or should I push it to
>>> arm-soc guys?
>>>
>>
>> Hi Dmitry,
>>
>> I can take this patch. I didn't response since I'm waiting the new
>> v3.13-rc1. I'm sorry on inconvenience.
>
> Nearly a week passed and I still don't see the patch either in arm-soc
> or in linux-next.
>
> --
> With best wishes
> Dmitry

Applied. I'll send the pull request in this week.

Best Regards
Haojian
