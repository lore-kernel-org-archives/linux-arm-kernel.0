From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 24 Jul 2015 13:29:29 -0700
Subject: [RFC 1/3] docs: dts: Added documentation for Xilinx Zynq PL Reset
 bindings.
In-Reply-To: <20150724145027.GY2531@xsjsorenbubuntu>
References: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
 <1437691862-21312-2-git-send-email-moritz.fischer@ettus.com>
 <55B1C1CB.2050402@xilinx.com>
 <20150724145027.GY2531@xsjsorenbubuntu>
Message-ID: <CAAtXAHfjTFydjjgHasb2LD-6r+zJL9K34fL3co55iGQo1_7f-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal, S?ren,

On Fri, Jul 24, 2015 at 7:50 AM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Fri, 2015-07-24 at 06:40AM +0200, Michal Simek wrote:
>> On 07/24/2015 12:51 AM, Moritz Fischer wrote:
>> > Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> > ---
>> >  Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>> > new file mode 100644
>> > index 0000000..ac4499e
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>> > @@ -0,0 +1,13 @@
>> > +Xilinx Zynq PL Reset Manager
>>
>> I think there is no reason to be just PL specific.
>
> That was my first thought too. Why not model all the resets in the SLCR?


I only needed the ones for the PL for my fpga-mgr work and reading the
TRM had a hard time to decide which ones make sense,
and which ones don't make sense to expose to Linux. I'll look into
reworking it to support all the resets.

>         S?ren

Moritz
