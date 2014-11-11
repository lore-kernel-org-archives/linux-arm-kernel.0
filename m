From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 11 Nov 2014 09:41:58 +0200
Subject: [PATCH 3/4] arm: dts: omap3-gta04: Add handling for tv output
In-Reply-To: <20141110233050.GC31454@atomide.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-4-git-send-email-marek@goldelico.com>
 <20141110233050.GC31454@atomide.com>
Message-ID: <5461BDC6.7090308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 11/11/14 01:30, Tony Lindgren wrote:
> * Marek Belisko <marek@goldelico.com> [141103 14:01]:
>> Add handling for gta04 tv out chain:
>> venc -> opa362 -> svideo
>>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>>  arch/arm/boot/dts/omap3-gta04.dtsi | 48 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
> 
> Applying this patch into omap-for-v3.19/dt thanks.

There are changes needed for this series, so don't apply yet.

I'll try to find the time to do a review and send comments soon.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/830244d6/attachment-0001.sig>
