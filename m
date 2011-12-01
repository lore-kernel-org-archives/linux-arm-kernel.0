From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Thu, 1 Dec 2011 11:10:11 +0100
Subject: [PATCH 2a/5 v2] ARM: OMAP1: select clock rate by CPU type
In-Reply-To: <20111130222837.GR31337@atomide.com>
References: <20111128174508.GO31337@atomide.com>
 <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111130222837.GR31337@atomide.com>
Message-ID: <201112011110.11476.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 of November 2011 at 23:28:38, Tony Lindgren wrote:
> 
> We should also now be able to remove all the CONFIG_OMAP_ARM_XXXMHZ options
> too, right?

Right, but then, perhaps the initial version of patch 2a/5, which 
already started removing them, from omap1_defconfig for now, then going 
into the right direction while unblocking another regression fix (3/5), 
_is_ a good candidate for an rc fix?

Thanks,
Janusz
