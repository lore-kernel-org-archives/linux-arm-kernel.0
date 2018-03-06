From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2018 14:19:22 +0100
Subject: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <20180306130551.GA16061@amd>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
 <20180306125416.GD26143@lunn.ch> <20180306130551.GA16061@amd>
Message-ID: <CAK8P3a2VvaFMO6jsx09ukN+=tj7sRZ9mkYGcSRiO1Fe6==sJ9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2018 at 2:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2018-03-06 13:54:16, Andrew Lunn wrote:
>> On Tue, Mar 06, 2018 at 01:40:02PM +0100, Pavel Machek wrote:
>> > Hi!
>> >
>> > > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> > > ---
>> > >  .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++++++++++++
>> > >  1 file changed, 73 insertions(+)
>> > >  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> > > new file mode 100644
>> > > index 000000000000..8a86f346d550
>> > > --- /dev/null
>> > > +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> > > @@ -0,0 +1,73 @@
>> > > +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
>> >
>> > Are these SoCs x86-based?
>>
>> ARM, as far as i can tell. If i get the architecture correct, these
>> are BMC, Board Management Controllers, looking after the main x86 CPU,
>> stopping it overheating, controlling the power supplies, remote
>> management, etc.
>
> Ok, so with x86 machine, I get arm-based one for free. I get it. Is
> user able to run his own kernel on the arm system, or is it locked
> down, TiVo style?

In the past, they were all locked down, the team submitting those
patches in working on changing that. Have a look for OpenBMC.

       Arnd
