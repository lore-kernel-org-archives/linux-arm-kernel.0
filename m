From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 16:01:55 +0200
Subject: [PATCH v3] ARM: tango: add Suspend-to-RAM support
In-Reply-To: <577E543E.80401@sigmadesigns.com>
References: <5773D3FB.4030101@sigmadesigns.com>
 <577A25F8.80702@sigmadesigns.com> <577E543E.80401@sigmadesigns.com>
Message-ID: <3357484.uFrtXQllNK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2016 3:08:14 PM CEST Marc Gonzalez wrote:
> Ask firmware to put RAM in self-refresh mode and power system down.
> 
>     echo mem > /sys/power/state
> 
> See Documentation/power/states.txt
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> v3 is identical to v2 minus the RFC tag
> Olof, if still possible, please merge for v4.8

Applied to next/soc, thanks!

	Arnd
