From: anders.berg@avagotech.com (Anders Berg)
Date: Thu, 15 May 2014 14:37:26 +0200
Subject: [PATCH v3 0/6] Add platform support for LSI AXM55xx
In-Reply-To: <6334605.NlytHCzYVP@wuerfel>
References: <cover.1400072260.git.anders.berg@avagotech.com>
 <6334605.NlytHCzYVP@wuerfel>
Message-ID: <CAE0=X_15Yk3VhHTwG-piA_eYL1mKW9wu_Szp-yL0YyfL8m0ecA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 8:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 May 2014 20:37:55 Anders Berg wrote:
>>
>> This is version 3 of this series to introduces basic platform support for the LSI
>> AXM5516 SoC.
>>
>> No major changes since v2. Ready to be applied to the arm-soc tree?
>
> I think it's good, but I'm not sure if we should put them all into arm-soc.
> There are no dependencies between the drivers that I can see, so why not
> merge the clock and reset drivers through the individual subsystem maintainers?
>

After suggestions from Mike on the clk driver (and it's dts binding)
I've done an updated clock driver patch - and a dependency surfaced...
The file <dt-bindings/clock/lsi,axm5516-clks.h>. Which way should this
take, arm-soc or Mikes clk tree? Perhaps this is a reason to take it
all through arm-soc?

/Anders
