From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 22 Mar 2013 15:31:09 +0100
Subject: [PATCH 0/4 v3] mv643xx_eth: use mvmdio MDIO bus driver
In-Reply-To: <20130322142924.GK13280@titan.lakedaemon.net>
References: <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363959568-16976-1-git-send-email-florian@openwrt.org>
 <20130322141423.GJ13280@titan.lakedaemon.net> <514C69B7.8090106@openwrt.org>
 <20130322142924.GK13280@titan.lakedaemon.net>
Message-ID: <514C6B2D.5000100@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/22/13 15:29, Jason Cooper a ?crit :
>> Ok, thanks! Does that mean that you want these changes to go via
>> your tree? David initially applied my v2 of this patchset, and since
>> it thouches mostly ethernet driver stuff, I would rather make it go
>> via his tree if both of you agree.
>
> Yeah, I thought I should have reworded that after I hit send :)  I
> simply meant it applied cleanly against v3.9-rc3, booted, and worked.  I
> Acked it so David could take the whole series through his tree.  Sorry
> for the confusion.
>
> Now that I can build mv643xx_eth DT on top of this, I'll structure it so
> those changes go on top of yours (in David's tree) and try to avoid the
> external dependency for the DT bits going though arm-soc.

Sounds good! FYI, I am finishing up DSA Device Tree bindings so that we 
can finally get rid of board-specific Kirkwood files.
--
Florian
