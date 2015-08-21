From: benoar@dolka.fr (Benjamin Cama)
Date: Fri, 21 Aug 2015 13:33:56 +0200
Subject: [PATCH] ARM: orion5x: fix legacy orion5x IRQ numbers
In-Reply-To: <1439648246-32757-1-git-send-email-gregory.clement@free-electrons.com>
References: <1439648246-32757-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1440156836.5070.9.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gr?gory,

Le samedi 15 ao?t 2015 ? 16:17 +0200, Gregory CLEMENT a ?crit :
> I amended the patch from Benjamin as it break the build for
> dove. Could you test it again wit this version?

Thanks for the fix. I don't have much time to test it, but as the dts
conversion patch for my Linkstation Mini is in the series, this fix
shouldn't change anything, as the dts board file uses the generic
irqchip handler, isn't it?

Tell me if I missed something. Regards,
--
benjamin
