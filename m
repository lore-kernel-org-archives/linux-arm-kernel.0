From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Jan 2015 09:01:05 +0800
Subject: [PATCH v8 4/6] input: misc: Add ABI docs for AXP20x PEK
In-Reply-To: <20150115173930.GD33214@dtor-ws>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
 <1419303194-3075-5-git-send-email-wens@csie.org>
 <CAGb2v64AvP+niDrFU-vGGsXUoKD_kv34DqEPRFUZ0fiyeWiz9A@mail.gmail.com>
 <20150115173930.GD33214@dtor-ws>
Message-ID: <CAGb2v65ZNvAZEE7K9Wsiv5vHO4NO3QjT0CVnnLZyb59T2OgxOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 1:39 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Chen-Yu,
>
> On Fri, Jan 16, 2015 at 12:00:31AM +0800, Chen-Yu Tsai wrote:
>> On Tue, Dec 23, 2014 at 10:53 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> > From: Carlo Caione <carlo@caione.org>
>> >
>> > Add ABI entries for the PEK found on PMU X-Powers AXP202 and AXP209.
>>
>> Hi Dmitry,
>>
>> Would it be possible to take this patch through your tree?
>
> Actually I folded it into the original patch adding the code so it's
> already there.

Sorry I didn't look deep enough. Just looked at the commit messages.

Thanks again.

ChenYu

> Thanks.
>
>>
>>
>> Thanks
>> ChenYu
>>
>> > Signed-off-by: Carlo Caione <carlo@caione.org>
>> > [wens at csie.org: Fixed path for sysfs entries]
>> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> > ---
>> >  Documentation/ABI/testing/sysfs-driver-input-axp-pek | 11 +++++++++++
>> >  1 file changed, 11 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-driver-input-axp-pek b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
>> > new file mode 100644
>> > index 000000000000..a5e671b9fa79
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
>> > @@ -0,0 +1,11 @@
>> > +What:          /sys/class/input/input(x)/device/startup
>> > +Date:          March 2014
>> > +Contact:       Carlo Caione <carlo@caione.org>
>> > +Description:   Startup time in us. Board is powered on if the button is pressed
>> > +               for more than <startup_time>
>> > +
>> > +What:          /sys/class/input/input(x)/device/shutdown
>> > +Date:          March 2014
>> > +Contact:       Carlo Caione <carlo@caione.org>
>> > +Description:   Shutdown time in us. Board is powered off if the button is pressed
>> > +               for more than <shutdown_time>
>> > --
>> > 2.1.4
>> >
>
> --
> Dmitry
