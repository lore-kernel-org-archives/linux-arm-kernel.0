From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Mar 2013 04:37:39 -0700
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
In-Reply-To: <20130312111246.GD12700@titan.lakedaemon.net>
References: <20130312144714.39749c5b0bd1aea14c4d2ff8@canb.auug.org.au>
 <20130312062509.GQ21478@lunn.ch>
 <20130312111246.GD12700@titan.lakedaemon.net>
Message-ID: <CAOesGMgSzn+uCVEMKZgtorcNkdzzvntmnfoej5vN-AjF43pnyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 4:12 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Tue, Mar 12, 2013 at 07:25:09AM +0100, Andrew Lunn wrote:
>> On Tue, Mar 12, 2013 at 02:47:14PM +1100, Stephen Rothwell wrote:
>> > Hi Andrew,
>> >
>> > Today's linux-next merge of the akpm tree got a conflict in
>> > drivers/rtc/rtc-mv.c between commit 89c58c198b25 ("rtc: rtc-mv: Add
>> > support for clk to avoid lockups") from the arm-soc tree and commit "rtc:
>> > rtc-mv: use devm_rtc_device_register()" from the akpm tree.
>> >
>> > I fixed it up (I think - see below) and can carry the fix as necessary
>> > (no action is required).
>>
>> Hi Stephan
>>
>> Looks O.K. to me.
>>
>> Acked-by: Andrew Lunn <andrew@lunn.ch>
>
> Same here,
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>

We should make sure that future RTC changes get queued through AKPM
and not through us to avoid these kind of conflicts. Same as other
driver subsystems..


-Olof
