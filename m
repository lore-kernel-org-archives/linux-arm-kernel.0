From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Mar 2016 19:23:23 -0600
Subject: Tons of "no unit name" spam with make dtbs
In-Reply-To: <20160310180745.GD9329@atomide.com>
References: <20160310180745.GD9329@atomide.com>
Message-ID: <CAL_JsqJswSBTf+5Vdv2gg05nUg1008vPeh5MYDO_7WHAc=Dndw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 12:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hey Rob,
>
> I'm seeing tons of dtc spam with make dtbs (about 23k lines
> with multi_v7_defconfig!) with commit fa38a82096a1 ("scripts/dtc:
> Update to upstream version 53bf130b1cdd").
>
> Introducing something like this few days with merge window
> about to open seems to be in the "a bit intrusive" category
> to me :)
>
> Probably some of these changes should be reverted?

It is in -next, but I'm not planning to send to Linus this cycle.

Rob
