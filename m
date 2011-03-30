From: cjb@laptop.org (Chris Ball)
Date: Wed, 30 Mar 2011 12:57:06 -0400
Subject: [PATCH] mmc: change CONFIG of MMC_SDHCI based drivers from 'bool'
	to 'tristate'
In-Reply-To: <4D935E59.2020908@metafoo.de> (Lars-Peter Clausen's message of
	"Wed, 30 Mar 2011 18:46:17 +0200")
References: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
	<20110328143806.GC18721@S2100-06.ap.freescale.net>
	<m37hbihenx.fsf@pullcord.laptop.org> <4D935E59.2020908@metafoo.de>
Message-ID: <m3tyek7di5.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

On Wed, Mar 30 2011, Lars-Peter Clausen wrote:
> That patch doesn't make much sense. The config options are used to decide
> whether support for that platform should be build into the sdhci-platform or
> sdhci-of module. So setting them 'm' doesn't make any sense, since you can't
> build part of an module as a module. The effect for 'm' will probably be the
> same as for 'n'.

Thanks, makes sense -- I'll drop the patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
