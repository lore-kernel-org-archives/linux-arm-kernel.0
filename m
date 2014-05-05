From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 5 May 2014 20:10:00 +0530
Subject: [PATCH 1/2] PM / OPP: Remove cpufreq wrapper dependency on
 internal data organization
In-Reply-To: <CAGo_u6pcEKDiAqvJW66_p7M7D0noFj6o9Rw5_d8Af3NMBhHA=g@mail.gmail.com>
References: <1399296830-13056-1-git-send-email-nm@ti.com>
 <1399296830-13056-2-git-send-email-nm@ti.com>
 <CAKohpomeP3Ftx8mH=x0Hj7HEpw6A9X8O8JEFqvrJbkZYDqDS6Q@mail.gmail.com>
 <CAGo_u6pcEKDiAqvJW66_p7M7D0noFj6o9Rw5_d8Af3NMBhHA=g@mail.gmail.com>
Message-ID: <CAKohponPGO511A--_sh5LYM6txgv5LTEy+n4RpshC8WH1CyEgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2014 19:55, Nishanth Menon <nm@ti.com> wrote:
> On Mon, May 5, 2014 at 9:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>>
>> What if opp is being added for some reason at the same time?
>> I hope we can surely see some awkward results, maybe some
>> NULL pointers invocations as well..
>
> we wont - rcu operations ensure that.

Stupid !!

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
