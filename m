From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 2 Feb 2017 20:43:52 +0000
Subject: [PATCH RESEND] ARM: ep93xx: Disable TS-72xx watchdog before
 uncompressing
In-Reply-To: <20170202201226.29631-1-f.fainelli@gmail.com>
References: <20170202201226.29631-1-f.fainelli@gmail.com>
Message-ID: <SN1PR0101MB1565DDD368EF9D0F9F9ACD9DD04C0@SN1PR0101MB1565.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 02, 2017 1:12 PM, Florian Fainelli wrote:
> The TS-72xx/73xx boards have a CPLD watchdog which is configured to
> reset the board after 8 seconds, if the kernel is large enough that this
> takes about this time to decompress the kernel, we will encounter a
> spurious reboot.
>
> Do not pull ts72xx.h, but instead locally define what we need to disable
> the watchdog.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Arnd, this is a recent, so you can queue this up, thanks!

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

or Tested-by/Acked-by as appropriate...

Hartley
