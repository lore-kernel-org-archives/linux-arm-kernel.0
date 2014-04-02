From: menon.nishanth@gmail.com (menon.nishanth at gmail.com)
Date: Wed, 2 Apr 2014 11:59:30 -0500
Subject: OMAP baseline test results for v3.14
In-Reply-To: <20140402163521.GD12234@atomide.com>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
 <20140402162102.GB12234@atomide.com>
 <alpine.DEB.2.02.1404021631040.15928@utopia.booyaka.com>
 <20140402163521.GD12234@atomide.com>
Message-ID: <CAGo_u6qJt5BRQHDvRjWe7Gjt+AfEBxaOPxCnq66QxMUdZew3Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 11:35 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Paul Walmsley <paul@pwsan.com> [140402 09:36]:
>> On Wed, 2 Apr 2014, Tony Lindgren wrote:
>>
>> > * Paul Walmsley <paul@pwsan.com> [140402 09:07]:
>> > >
>> > > Here are some basic OMAP test results for Linux v3.14.
>> > > Logs and other details at:
>> > >
>> > >     http://www.pwsan.com/omap/testlogs/test_v3.14/20140402004448/
>> > >
>> > > Boot to userspace:
>> > >     FAIL ( 1/12): 2430sdp
>> >
>> > Is this a new regression with MMC? Looks like your boot log for this
>> > ends with "Waiting for root device /dev/mmcblk0p1...".
>>
>> It's new since v3.14-rc1:
>>
>> http://www.spinics.net/lists/arm-kernel/msg306448.html
>>
>> http://www.spinics.net/lists/arm-kernel/msg306454.html
>>
>> http://www.spinics.net/lists/arm-kernel/msg306455.html
>
> OK looks like I never noticed that one before. Probably
> because of NFSroot.
Paul uses MMC filesystem, I use NFS. As Felipe Pointed out as well, I
did rootcause MMC filesystem mount issue here:
http://marc.info/?l=linux-omap&m=139637044425644&w=2

NFS does work for me on 3.14 tag  http://slexy.org/raw/s20plaLoaT (on SDP2430)

Regards,
Nishanth Menon
