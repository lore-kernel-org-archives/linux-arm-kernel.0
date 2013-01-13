From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 13 Jan 2013 20:40:29 +0100
Subject: [PATCH v2] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <20130111145629.GB31640@titan.lakedaemon.net>
References: <1588881.pi23bvqp7D@bender> <3816648.2TVsTiMOWx@bender>
 <50F02570.9050208@openwrt.org> <20130111145629.GB31640@titan.lakedaemon.net>
Message-ID: <50F30DAD.3090105@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/01/2013 15:56, Jason Cooper a ?crit :
> Florian,
>
> On Fri, Jan 11, 2013 at 03:45:04PM +0100, Florian Fainelli wrote:
>> Le 01/09/13 20:56, Florian Fainelli a ?crit :
>>> This patch adds the DTS file to support the Marvell RD-A370-A1
>>> (Reference Design board) also known as RD-88F6710 board. It is almost
>>> entirely similar to the DB-A370 board except that the first Ethernet PHY
>>> is SGMII-wired and the second is a switch which is RGMII-wired.
>>
>> Who is going to take this patch? Since this is a new DTS file there
>> are little chances it breaks anything, could it be taken for an
>> upcoming 3.8-rc?
>
> No, only fixes go in for the current -rc.  It'll be included for v3.9, I
> have it in my queue.

Jason, I don't see this patch in the pull request you just sent for 3.9, 
should it be? Thanks!
--
Florian
