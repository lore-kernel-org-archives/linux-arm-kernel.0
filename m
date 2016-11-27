From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Nov 2016 22:50:22 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <20161127212709.GD13318@lunn.ch>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
 <1480280279-9552-2-git-send-email-afaerber@suse.de>
 <20161127212709.GD13318@lunn.ch>
Message-ID: <9500470d-09c3-3ecb-994b-3d108bffc99e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.11.2016 um 22:27 schrieb Andrew Lunn:
> On Sun, Nov 27, 2016 at 09:57:59PM +0100, Andreas F?rber wrote:
>> This model is found on the Turris Omnia.
> 
> This driver already supports nearly 30 different Marvell switch
> models. Please document why the marvell,mv88e6176 is special and why
> it needs its own compatible string when the others don't.

I don't understand.

The commit message above already points out for which device this is
(and you also know from the LAKML thread).

You as driver author should know that the .data pointer is vital to your
driver - you even recently accepted another model that conflicted with
my patch. So are you arguing for a ", which uses a Device Tree for
booting" half-sentence here?

The others not having an entry simply means no one needed them yet.

And any Turris Omnia side changes need to go through the mvebu tree.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
