From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 14 Jan 2013 10:36:57 +0100
Subject: [PATCH v2] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <20130113201236.GO13433@titan.lakedaemon.net>
References: <1588881.pi23bvqp7D@bender> <3816648.2TVsTiMOWx@bender>
 <50F02570.9050208@openwrt.org> <20130111145629.GB31640@titan.lakedaemon.net>
 <50F30DAD.3090105@openwrt.org> <20130113201236.GO13433@titan.lakedaemon.net>
Message-ID: <50F3D1B9.9070002@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/13/13 21:12, Jason Cooper a ?crit :
> On Sun, Jan 13, 2013 at 08:40:29PM +0100, Florian Fainelli wrote:
>> Le 11/01/2013 15:56, Jason Cooper a ?crit :
>>> Florian,
>>>
>>> On Fri, Jan 11, 2013 at 03:45:04PM +0100, Florian Fainelli wrote:
>>>> Le 01/09/13 20:56, Florian Fainelli a ?crit :
>>>>> This patch adds the DTS file to support the Marvell RD-A370-A1
>>>>> (Reference Design board) also known as RD-88F6710 board. It is almost
>>>>> entirely similar to the DB-A370 board except that the first Ethernet PHY
>>>>> is SGMII-wired and the second is a switch which is RGMII-wired.
>>>> Who is going to take this patch? Since this is a new DTS file there
>>>> are little chances it breaks anything, could it be taken for an
>>>> upcoming 3.8-rc?
>>> No, only fixes go in for the current -rc.  It'll be included for v3.9, I
>>> have it in my queue.
>> Jason, I don't see this patch in the pull request you just sent for
>> 3.9, should it be? Thanks!
> Not yet, I'm working my though the holiday backlog chronologically.

Ok, then you might want to hold this one a little, so I add mvsdio 
bindings to this DTS file as well. Thanks!
--
Florian
