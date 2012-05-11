From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 May 2012 13:22:14 +0000
Subject: [PATCH RESEND v8] gpio: Device tree support for LPC32xx
In-Reply-To: <4FAD0A79.8040207@antcom.de>
References: <1336679838-30738-1-git-send-email-stigge@antcom.de>
 <201205111219.10025.arnd@arndb.de> <4FAD0A79.8040207@antcom.de>
Message-ID: <201205111322.15191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 May 2012, Roland Stigge wrote:
> Right. Personally, I would be fine with either of my v8 (all banks in
> dt, referenced naturally by name) and v9 (one simple DT entry for the
> whole GPIO controller, integer index for referencing banks) patches.
> 
> Consider the DT-documented mapping in the latter case:
> 
>       0: GPIO P0
>       1: GPIO P1
>       2: GPIO P2
>       3: GPIO P3
>       4: GPI P3
>       5: GPO P3
> 
> Not too difficult and would also be acceptable, IMO.
> 
> So Arnd and Grant, please agree one of those and pick it. :-)
> 

Grant is maintainer for both GPIO and DT, so his opinion is what
counts in this case.
I was merely giving the background on how we got there so he
can make an informed decision.

	Arnd
