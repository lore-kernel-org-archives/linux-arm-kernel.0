From: nm@ti.com (Menon, Nishanth)
Date: Fri, 13 Jul 2012 00:29:08 -0500
Subject: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional
 states
In-Reply-To: <4FFFB19D.2090808@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
 <1339685591-11177-3-git-send-email-j-pihet@ti.com>
 <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
 <4FFFB19D.2090808@ti.com>
Message-ID: <CAOMWX4ctd20p2qBKyVBEE7PxXaEoExMivnE9Kcx6Om1w6U5yCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 12:26 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 13 July 2012 08:31 AM, Menon, Nishanth wrote:
>>
>> my Crib about the above apis are lack of logic power state handling:(
>> which forces code like cpuidle to use different apis for logic
>> power state and force them to use these apis just for pwrst.
>
>
> Have you looked at an alternate approach that was proposed here..
> https://patchwork.kernel.org/patch/1160431/
>
Santosh pointed me to the thread offline. This is indeed a much better
approach IMHO than having 3 conflicting options inside powerdomain
framework.

Regards,
Nishanth Menon
