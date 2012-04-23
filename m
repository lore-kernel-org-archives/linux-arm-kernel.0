From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 23 Apr 2012 17:51:20 +0530
Subject: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
In-Reply-To: <4F9547E3.4000709@arm.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
 <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
 <4F9514AA.10403@arm.com>
 <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
 <4F9547E3.4000709@arm.com>
Message-ID: <CAOh2x==ADdGi5gdsn0naVtU_g2cq6gBBxxz11LOVfYiwyCA-Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/04/12 12:35, viresh kumar wrote:
>> - subtract 0x20 from base address for DT case
>
> That's a possibility.
>
>> - something else.
>
> Given that no in-tree platform seem to be using this watchdog (at least
> a quick grep didn't reveal anything), I'd be inclined to simply change
> the offset in smp_twd.h and let them break.

I believe atlest ST Ericsson's Ux500 series is using it, Linus??

Obviously the best solution is to fix these offsets and pass watchdog
base address from DT or machine/board files.

I will see what i can do best.

--
viresh
