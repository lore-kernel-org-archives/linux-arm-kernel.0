From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 7 Jun 2013 15:23:13 +0530
Subject: [PATCH 14/14] ARM: OMAP4: hwmod data: Clean up the data file
In-Reply-To: <alpine.DEB.2.02.1306070949300.32163@utopia.booyaka.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-15-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306061754560.5152@utopia.booyaka.com>
 <51B0D54A.1090107@ti.com> <51B175E4.1060909@ti.com>
 <alpine.DEB.2.02.1306070751210.32163@utopia.booyaka.com>
 <51B1A150.9020307@ti.com> <1370598383.25965.73.camel@sokoban>
 <alpine.DEB.2.02.1306070949300.32163@utopia.booyaka.com>
Message-ID: <51B1AD89.4090006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 03:20 PM, Paul Walmsley wrote:
> On Fri, 7 Jun 2013, Tero Kristo wrote:
>
>> On Fri, 2013-06-07 at 14:31 +0530, Sricharan R wrote:
>>> On Friday 07 June 2013 01:22 PM, Paul Walmsley wrote:
>>>> cc Beno?t
>>>>
>>>> On Fri, 7 Jun 2013, Sricharan R wrote:
>>>>
>>>>> I used autogen to remove the data, but some of the data were not in sync
>>>>> with the mainline .(like abe, dss, aess, context register offsets etc..).
>>>>> So i have to sync them manually.
>>>> OK.  Are you going to fix the differences up soon?
>>>>
>>>> - Paul
>>> + Ambresh and Tero for autogen.
>> This is not going to happen soon, if ever. We might consider doing this
>> if a complete overhaul for the hwmod data is going to be done at some
>> point so that re-generating the new format is easier.
> OK.  Sricharan, how about reposting the OMAP4 hwmod data patch and drop 
> the comment regarding autogeneration?  That will be more accurate and will 
> save some more lines.
>
>
> - Paul
ok, sure, i will repost by dropping that comment.

Regards,
 Sricharan
