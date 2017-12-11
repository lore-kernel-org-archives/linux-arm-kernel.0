From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Dec 2017 21:08:00 -0200
Subject: [PATCH v2 1/5] dt-bindings: rtc: add bindings for i.MX53 SRTC
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-2-linux-kernel-dev@beckhoff.com>
 <20171206215436.lwttn445wjilh3wo@rob-hp-laptop>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
Message-ID: <CAOMZO5DoiLW3DxLF=agHua9jO-+LgWA3xw6h7kyj_uot47pkjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Mon, Dec 11, 2017 at 5:08 AM, Patrick Br?nn <P.Bruenn@beckhoff.com> wrote:

>>rtc at ...
>>
> The rtc for which this series adds support is embedded within a function block called
> "Secure Real Time Clock". This driver doesn't utilize all of the hardware features by
> now. But maybe someone else wants to extend the functionalities, later.
> For that possibility I wanted to name the node "srtc". Should I still change this?
>
> I believe you have a much better understanding of what should be done here. I don't
> want to argue with you, just thought you might not had that information. So if I am
> wrong just tell me and I will change it without further "complaining".

>From the Devicetree Specification document:

"Generic Names Recommendation

The name of a node should be somewhat generic, reflecting the function
of the device and not its precise program-
ming model. If appropriate, the name should be one of the following choices:
...
rtc
"

So better use 'rtc' as suggested by Rob.
