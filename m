From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 6 Apr 2012 22:30:48 -0400
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120406182122.GA13649@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <CAMiH66EC7=x0sRYhE3hpEyBemDGSRS19xguQUqKj2kuPw5Tifw@mail.gmail.com>
 <20120404122335.GD17187@pengutronix.de>
 <CAMiH66GM0RxP-z=HNkOhhPaaXCZLKPvWFy=_+aGbbGSdrsg+iQ@mail.gmail.com>
 <20120406182122.GA13649@pengutronix.de>
Message-ID: <CAMiH66GxZoT-PDfkqBOFfn2jXi6n7B0jiDmMUV9GpT09J3z2yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 6, 2012 at 2:21 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> > where 2-4 can probably happen more or less simultaneously.
>> I wish you could send out the new patch as soon as possible. :)
>
> Is a new version needed? I thought that this version could go in...

emm..
If you think this version is ok, I will ask Artem to accept another patch:
"  mtd/gpmi : do not include the mxs.h".

My other patches depend on this patch. And they have been delayed for some time.

thanks
Huang Shijie

>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
