From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 28 Mar 2012 10:18:24 -0700
Subject: [PATCH 02/10] clk: remove unnecessary EXPORT_SYMBOL_GPL
In-Reply-To: <20120328054233.GA2954@lunn.ch>
References: <20120327092828.GA16397@lunn.ch>
 <20120327131002.GC3719@S2101-09.ap.freescale.net>
 <CAJOA=zMEtyYuPwSAnnJ2PUnymkn-QWD7rJaymemH5on21EB4Sw@mail.gmail.com>
 <20120328054233.GA2954@lunn.ch>
Message-ID: <CAJOA=zOR1PQ7WmKve8uBBtMr=zvDToHp5y_bm4Piigio7x7n_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 10:42 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > I have a similar need for clk_divider_ops calls. ?Instead of exporting
>> > every single clk_gate_ops call, we should just export "struct clk_ops
>> > clk_gate_ops". ?That's exactly why I have the patch #4 here.
>>
>> Andrew, does this approach work for you? ?I prefer it over the EXPORT madness.
>
> Hi Mike
>
> I think so. I'm waiting for the first 3.4 RC to come out so I've not
> tried implementing it yet.

In that case I'm going to roll it into my fixes branch.  I want to
send that branch to Arnd ASAP so I can't afford to wait on feedback
from -rc1.  Please do shout if you find it problematic after -rc1,
though.

Thanks,
Mike
