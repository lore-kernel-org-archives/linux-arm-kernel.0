From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Apr 2016 18:05:11 +0100
Subject: [PATCH] ARM: arm64: dts: Add expansion bus to VExpress and Juno
In-Reply-To: <1459786850-29409-1-git-send-email-brian.starkey@arm.com>
References: <1459786850-29409-1-git-send-email-brian.starkey@arm.com>
Message-ID: <57029EC7.8030802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/04/16 17:20, Brian Starkey wrote:
> The VExpress and Juno development platforms have an external expansion
> bus which can be used for additional hardware (e.g. LogicTile Express
> daughterboards).

How do you plan to add those additional hardware on the expansion bus ?

IIUC having them in DT and running on a system without the tile
connected will cause aborts, hence you are just adding bus definition.

Is there any use in having just the bus definition in DT. If you are
planning to add devices using overlays, can't the bus definition also
be added then ?

I am fine with the patch as such, just wanted to know the information.

-- 
Regards,
Sudeep
