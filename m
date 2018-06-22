From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 22 Jun 2018 16:44:04 +0000
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
 <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
Message-ID: <TY1PR01MB15624342267F973525BF45698A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 22, 2018 1, Nicolas Pitre wrote:
> All that is possible already. But config symbol mutual exclusion is not.

I still don't understand why we need some false sense of security for 
only selecting 1 platform.

There are probably plenty of kernel config options that you could enable
that would break any number of systems.

So, why do we feel that XIP_KERNEL needs a warm safety blanket around 
it?

Chris
