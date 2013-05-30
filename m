From: pekon@ti.com (Gupta, Pekon)
Date: Thu, 30 May 2013 06:44:02 +0000
Subject: [PATCH] dts: am33xx: Correct properties on gpmc node
In-Reply-To: <87mwrfbfgv.fsf@dell.be.48ers.dk>
References: <1369729497-11897-1-git-send-email-larsi@wh2.tu-dresden.de>
 <87mwrfbfgv.fsf@dell.be.48ers.dk>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9C8B98@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>>> "Lars" == Lars Poeschel <larsi@wh2.tu-dresden.de> writes:
> 
>  Lars> From: Lars Poeschel <poeschel@lemonage.de>
>  Lars> The gpmc driver is actually looking for "gpmc,num-cs" and
>  Lars> "gpmc,num-waitpins" properties in DT. The binding doc also states
>  Lars> this.
>  Lars> Correct the properties in the dts to provide the right values for the
>  Lars> gpmc driver.
> 
>  Lars> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
Acked-by: Pekon Gupta <pekon@ti.com>

My another patch [V3, 2/3] on same can be dropped, in lieu of this one..
http://www.spinics.net/lists/linux-omap/msg91167.html


with regards, pekon
