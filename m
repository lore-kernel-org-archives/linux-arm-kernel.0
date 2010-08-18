From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 18 Aug 2010 12:08:44 +0800
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <871vaaycz0.fsf@free.fr>
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<201008011738.16225.marek.vasut@gmail.com>
	<20100803020328.1046308a@linux.lan.towertech.it>
	<201008030510.03205.marek.vasut@gmail.com>
	<20100806215955.06572bfa@linux.lan.towertech.it>
	<871vaaycz0.fsf@free.fr>
Message-ID: <AANLkTikkfq_Wd=XKqVREG50q=+2pbPij3EhtnJ7nsfRM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 7, 2010 at 5:43 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Alessandro Zummo <a.zummo@towertech.it> writes:
>
>> On Tue, 3 Aug 2010 05:10:03 +0200
>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>
>>> > ?may I see the latest version of your patch, Marek?
>>> >
>>> > ?ty
>>> ---
>>> ?drivers/rtc/rtc-pxa.c | ? ?4 ++--
>>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> ?well, if it's ok for Robert...
>
> Yes, I already gave my ack in [1].
>
> As I'm still on holidays, I won't be available for a couple of days again, so
> take it granted that IMO Marek's patch can go in your tree and that it has my
> full aggreement. Thanks.
>

Hi Alessandro,

Cann't find this in -next so far, the patch looks correct to me. We did
the same thing for rtc-sa1100.c before. So you also have my Ack on
this if it's not yet in your tree.

> --
> Robert
>
> [1] http://www.spinics.net/lists/arm-kernel/msg94818.html
>
