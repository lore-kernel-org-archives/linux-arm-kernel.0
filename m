From: jon.nettleton@gmail.com (Jon Nettleton)
Date: Tue, 8 Sep 2015 19:07:58 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150908155533.GA21084@n2100.arm.linux.org.uk>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de>
 <20150908110135.GW21084@n2100.arm.linux.org.uk>
 <1441710467.13536.13.camel@pengutronix.de>
 <20150908112909.GX21084@n2100.arm.linux.org.uk>
 <1441716233.13536.21.camel@pengutronix.de>
 <CAOCHtYhtkV-TtaA6hz1OTD5TpGCnionK27D2mp4beU+HGymwdw@mail.gmail.com>
 <20150908155533.GA21084@n2100.arm.linux.org.uk>
Message-ID: <CALHpu35Kxbwwm37rLTWzZhmE_UenWZ9eQdcytW2kLUxfT2ywJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 8, 2015 at 5:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 08, 2015 at 09:17:06AM -0500, Robert Nelson wrote:
>> >> I
>> >> suspect that the iMX6 is going to be obsolete before we have a decent
>> >> working video playback story on this hardware.
>> >>
>> > MX6Plus is just around the corner and will probably keep us busy for a
>> > while. ;)
>>
>> Lucas,
>>
>> In which case, it "might" be a good idea to get the current version of
>> etnaviv in mainline for current imx6's before you guys disappear again
>> for mx6plus development..
>>
>> As you guys are basically repeating what happened with the limadriver:
>> http://limadriver.org/
>>
>> Remember, there is an etnaviv community.
>>
>> Russell:
>> is there any reason to not just push your version for mainline and let
>> Pengutronix submit patches.
>
> The basic problem is getting the kernel<->user API stable before it
> goes into mainline, which is an absolute must.  We can't drop it into
> mainline and then break the user API.
>
> We also want to avoid putting it into the staging tree and have it
> sit around there for years.
>

If you don't have much time to work on it then lets get it pushed to
the github community repos where we can have everyone else submit
patches.  We have #etnaviv where we can coordinate efforts.  Even if
something is on a todo list lets get it out where we someone else can
work on it.  I think our community is strong enough that we can all
make progress without stepping on each others feet.
