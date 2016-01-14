From: kvalo@codeaurora.org (Kalle Valo)
Date: Thu, 14 Jan 2016 09:05:48 +0200
Subject: [PATCH v4 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
In-Reply-To: <20160113172712.GI12777@atomide.com> (Tony Lindgren's message of
 "Wed, 13 Jan 2016 09:27:12 -0800")
References: <1451482533-8624-1-git-send-email-uri.mashiach@compulab.co.il>
 <1451482533-8624-4-git-send-email-uri.mashiach@compulab.co.il>
 <87io35lq2p.fsf@kamboji.qca.qualcomm.com>
 <5695E802.7050909@compulab.co.il> <20160113172712.GI12777@atomide.com>
Message-ID: <87wprcbpyr.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

>> >>  arch/arm/boot/dts/am335x-cm-t335.dts | 55 ++++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 55 insertions(+)
>> > 
>> > To what tree should this patch go? My wireless-drivers-next tree doesn't
>> > even have this file.
>> 
>> Right. It will hit the mainline during this merge window through Tony's and
>> arm-soc trees.
>> 
>> Do you think it will be sensible if you take 1/3 and 2/3 patches and Tony
>> will take the 3/3 (there is no code dependency between first two and the last one),
>> or we can just wait till arm-soc hits the mainline, so you will have the
>> needed code?
>
> Yeah I'll pick the dts changes separately after the merge window as
> there is no dependency to the driver changes.

Ok, I'll then take patches 1 and 2 once the merge window opens.

-- 
Kalle Valo
