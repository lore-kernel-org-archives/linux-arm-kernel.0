From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 11 Jan 2013 15:53:13 +0100
Subject: [PATCH v2] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <50F02570.9050208@openwrt.org>
References: <1588881.pi23bvqp7D@bender> <3816648.2TVsTiMOWx@bender>
 <50F02570.9050208@openwrt.org>
Message-ID: <50F02759.9010805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian,

On 01/11/2013 03:45 PM, Florian Fainelli wrote:
> Thomas, Gregory,
> 
> Le 01/09/13 20:56, Florian Fainelli a ?crit :
>> This patch adds the DTS file to support the Marvell RD-A370-A1
>> (Reference Design board) also known as RD-88F6710 board. It is almost
>> entirely similar to the DB-A370 board except that the first Ethernet PHY
>> is SGMII-wired and the second is a switch which is RGMII-wired.
> 
> Who is going to take this patch? Since this is a new DTS file there are 
> little chances it breaks anything, could it be taken for an upcoming 3.8-rc?

It is Jason who takes care of gathering all the patches for mvebu.

As it is not a fix for a bug but more a new "feature" (at least a support
for a new board), I doubt that it could be part of 3.8-rc.
But as far as I am concerned I am not against having this patch in 3.8-rc.

Regards

> 
> Thanks.
> --
> Florian
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
