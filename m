From: khilman@ti.com (Kevin Hilman)
Date: Thu, 01 Dec 2011 06:58:23 -0800
Subject: [RFC PATCH 00/11] arm:omap:am33xx: Add basic voltage, power,
 clock & HWMOD data
In-Reply-To: <79CD15C6BA57404B839C016229A409A804761D@DBDE01.ent.ti.com>
 (Vaibhav Hiremath's message of "Thu, 1 Dec 2011 12:02:18 +0000")
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
 <87ty5lt6dm.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A804761D@DBDE01.ent.ti.com>
Message-ID: <87vcq0s5io.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Thursday, December 01, 2011 7:12 AM
>> To: Hiremath, Vaibhav
>> Cc: linux-omap at vger.kernel.org; tony at atomide.com; paul at pwsan.com; linux-
>> arm-kernel at lists.infradead.org; Cousson, Benoit
>> Subject: Re: [RFC PATCH 00/11] arm:omap:am33xx: Add basic voltage, power,
>> clock & HWMOD data
>> 
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > This patch series adds support for AM335X basic voltage, power,
>> > clock and HWMOD data to existing OMAP framework.
>> 
>> This series is missing patch 05/11.
>> 
> Ohhh...not sure what went bad.
>
> You can access it from, http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=commit;h=c2754eb60b65c6c574f2d6d871d8846358e40414
>
>
> I had published the whole series @ Arago.
>

OK, but using Arago, I will also get a bunch of other out of tree code.

Can you create a branch for base am33x support against a recent mainline
(like v3.2-rc3) for easier review/testing of just the AM33x support?

Kevin
