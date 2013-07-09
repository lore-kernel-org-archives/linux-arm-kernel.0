From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 09 Jul 2013 17:09:52 +0400
Subject: [PATCH] ARM: shmobile: Add SMSC ethernet chip to KZM9D DT
 reference
In-Reply-To: <CANqRtoQfkk9KFggw5dadqih-kqNTCGC+kVCKkOUO8G=1w+kh6g@mail.gmail.com>
References: <20130709042654.13658.20164.sendpatchset@w520>
 <51DBF7CD.8040009@cogentembedded.com>
 <CANqRtoQfkk9KFggw5dadqih-kqNTCGC+kVCKkOUO8G=1w+kh6g@mail.gmail.com>
Message-ID: <51DC0BA0.2060306@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-07-2013 17:03, Magnus Damm wrote:

>>> From: Magnus Damm <damm@opensource.se>

>>> Add support for the SMSC ethernet controller found
>>> on the KZM9D board to the KZM9D DT Reference code.

>>> Signed-off-by: Magnus Damm <damm@opensource.se>
>>> ---

>>>    Built on top of renesas-next-20130704v2 and
>>>    [PATCH] ARM: shmobile: KZM9D DT reference implementation

>>>    arch/arm/boot/dts/emev2-kzm9d-reference.dts |   31
>>> +++++++++++++++++++++++++++
>>>    1 file changed, 31 insertions(+)

>>> --- 0002/arch/arm/boot/dts/emev2-kzm9d-reference.dts
>>> +++ work/arch/arm/boot/dts/emev2-kzm9d-reference.dts    2013-07-09
>>> 13:06:47.000000000 +0900
>>> @@ -23,4 +23,35 @@

>> [...]

>>> +       lan9220 at 20000000 {

>>     Shouldn't all the Ethernet nodes be called "ethernet"?

> Good question. Grepping in arch/arm/boot/dts shows various ways to
> name the Ethernet nodes. Exactly what is correct or not I can't really
> say.

    See "Node Names" section of [1].

[1] http://www.devicetree.org/Device_Tree_Usage

> Thanks for your feedback.

> Cheers,

> / magnus

WBR, Sergei
