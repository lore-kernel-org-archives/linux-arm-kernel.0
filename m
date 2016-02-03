From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 3 Feb 2016 22:46:18 +0000
Subject: [PATCH v4 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <20160125094628.GH27359@ibawizard.net>
References: <1453675703-31594-1-git-send-email-marcel.ziswiler@toradex.com>
 <1453675703-31594-2-git-send-email-marcel.ziswiler@toradex.com>
 <20160125094628.GH27359@ibawizard.net>
Message-ID: <1454539575.11389.5.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr

On Mon, 2016-01-25 at 10:46 +0100, Petr ?tetiar wrote:

[snip]

> What problems are you having if you remove that parent regulators
> node?

To be honest I don't remember the exact issues it caused. I just tried
again now with latest?next-20160203 and besides slab being broken it
worked like a charm. So finally rid of it I got (;-p).

> 1. http://lists.infradead.org/pipermail/linux-arm-kernel/2015-Novembe
> r/386456.html
> 2. https://raw.githubusercontent.com/ynezz/linux-2.6/5a211784544a3a46
> 0df7e7e45479010ae3feaf76/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> 3. git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> 
> Thanks for your work!

You are very welcome.

> -- ynezz

Cheers

Marcel
