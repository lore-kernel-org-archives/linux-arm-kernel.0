From: dirk.behme@gmail.com (Dirk Behme)
Date: Fri, 18 Dec 2015 12:58:33 +0100
Subject: [PATCH 1/2] arm64: dts: r8a7795: Add Cortex-A53 CPU cores
In-Reply-To: <CAMuHMdVVL9T6U8npb5kOLdP3PmS6Lhx0b9O3FKgxd2HQcUedFw@mail.gmail.com>
References: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
 <CAMuHMdVVL9T6U8npb5kOLdP3PmS6Lhx0b9O3FKgxd2HQcUedFw@mail.gmail.com>
Message-ID: <5673F4E9.9070205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 18.12.2015 12:02, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Sat, Dec 12, 2015 at 8:16 AM, Dirk Behme <dirk.behme@gmail.com> wrote:
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> This patch adds Cortex-A53 CPU cores to r8a7795 SoC for a total of 8
>> cores (4 x Cortex-A57 + 4 x Cortex-A53).
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>
> Thanks, I can confirm this works.
>
> However, as the scheduler is not big.LITTLE aware (running processes are not
> migrated automatically to the faster CA57 cores when these are idle), it makes
> performance less deterministic.


What's the plan, then?

Waiting for big.LITTLE getting merged before enabling the A53? Or not 
using the A53 at all?

Best regards

Dirk
