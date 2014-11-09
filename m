From: mk@drkrebs.de (Markus Krebs)
Date: Sun, 09 Nov 2014 16:15:57 +0100
Subject: Network timing (?) problems since kernel 3.12
Message-ID: <545F852D.5040209@drkrebs.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm using a Sheevaplug (Marvell Kirkwood) with an USB-Stick for storage 
as a server. Since kernel 3.12 I'm experiencing various erratic problems 
when transferring files, especially large or many files at the same 
time, over the network (ssh complaining about "Corrupted MAC on input" 
or Windows [over Samba] about corrupt files).
Turning "offload check summing" off with ethtool didn't really help.

Kernel 3.11 shows no such behaviour. Has there been a significant change 
in the network driver or in the USB mass storage driver?
