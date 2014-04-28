From: tthayer.linux@gmail.com (T Thayer)
Date: Mon, 28 Apr 2014 18:37:21 -0500
Subject: [patch] Fix CAN on socfpga, for net/master
In-Reply-To: <20140428211505.GA28242@amd.pavel.ucw.cz>
References: <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
 <20140426093646.GE8730@amd.pavel.ucw.cz>
 <20140426203131.GA21832@amd.pavel.ucw.cz>
 <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
Message-ID: <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 4:15 PM, Pavel Machek <pavel@denx.de> wrote:
> Hi!
>
> On Mon 2014-04-28 15:20:49, Thor Thayer wrote:
>> On Sun, 2014-04-27 at 14:25 +0200, ZY - pavel wrote:
>> > Apparently, socfpga CAN needs 32-bit accesses and different raminit
>> > sequence.
>> >
>> > Signed-off-by: Pavel Machek <pavel@denx.de>
>> >
>> > ---
>> >
>> > >
>> > > I'm not in the office (and fighting with my phone's email client) until 5th of May, however please rebase all your patches against the latest net/master from David Miller, as this tree includes all c_can fixes by Thomas.
>> > >
>> >
>> > Ok, combined patch is here. Lightly tested using loopback on Arrow
>> > SocKit.
>>
>> Hi Pavel.
>>
>> Thanks for your help on the SOCFPGA support! I can test this on the
>> Altera Development Kit but I'm not able to cleanly apply to the latest
>> David Miller net-next branch. Is there a different branch I should
>> use?
>
> It should have been against net-next branch... but perhaps I made a
> mistake somewhere. I should get some sleep now.
>
> Or ... let me upload my tree so that you can generate the diff.
>
> You should be able to get it using:
>
> git pull git://git.denx.de/linux-denx-pavel.git my_net_master
>
>> I also like your updates to my patch as shown below - much cleaner.
>
> Thanks :-).
>
> Best regards,
>
>                                                                 Pavel

Hi Pavel,

I didn't get a chance to pull and test your patch but a visual
inspection looks good.

Since you based this patch on my original code, feel free to add my signed-off.

Thor

>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
