From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 27 Nov 2013 11:06:52 +0200
Subject: [PATCHv10 41/41] ARM: OMAP3: use DT clock init if DT data is
 available
In-Reply-To: <20131126174455.GF26766@atomide.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-42-git-send-email-t-kristo@ti.com>
 <20131126174455.GF26766@atomide.com>
Message-ID: <5295B62C.8090209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 07:44 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [131126 00:10]:
>> OMAP3 platforms support both DT and non-DT boot at the moment, make
>> the clock init work according to the used setup.
>
> We're making omap3 to be DT only as well, so it might make sense to
> drop the omap3 clock data as well while at it. Or do it later to
> avoid adding dependencies, up to you.

Ok, I can remove it with next rev if you like.

-Tero
