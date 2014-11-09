From: mk@drkrebs.de (Markus Krebs)
Date: Sun, 09 Nov 2014 17:56:37 +0100
Subject: Network timing (?) problems since kernel 3.12
In-Reply-To: <20141109155502.GA10013@lunn.ch>
References: <545F852D.5040209@drkrebs.de> <20141109155502.GA10013@lunn.ch>
Message-ID: <545F9CC5.6070709@drkrebs.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.11.2014 um 16:55 schrieb Andrew Lunn:

>> I'm using a Sheevaplug (Marvell Kirkwood) with an USB-Stick for
>> storage as a server. Since kernel 3.12 I'm experiencing various
>> erratic problems when transferring files, especially large or many
>> files at the same time, over the network (ssh complaining about
>> "Corrupted MAC on input" or Windows [over Samba] about corrupt
>> files).
>> Turning "offload check summing" off with ethtool didn't really help.
>
> Try turning off gso.

Thanks, Andrew; I've tried now but that didn't do the trick either.
