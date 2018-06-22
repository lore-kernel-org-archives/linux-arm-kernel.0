From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 22 Jun 2018 20:25:06 +0000
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <20180622183838.GZ17671@n2100.armlinux.org.uk>
References: <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
 <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
 <TY1PR01MB15624342267F973525BF45698A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <nycvar.YSQ.7.76.1806221244490.16670@knanqh.ubzr>
 <TY1PR01MB1562C54E8DD3942F40F8CBBD8A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20180622183838.GZ17671@n2100.armlinux.org.uk>
Message-ID: <TY1PR01MB1562F7C31AF6AFC4A1BBA1748A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 22, 2018, Russell King - ARM Linux wrote:
> > There are configs options today that you can select, but unless some
> > external criteria is  met during build time, the build will fail (like
> > with a "missing .h file" message or something)
> 
> Such as?  I don't think that's found by the randconfig builders - I've
> never noticed any such failures on ARM.

I got this set once by accident after a kernel update

   CONFIG_SYSTEM_TRUSTED_KEYRING=y

which then let me to this error:

  HOSTCC  scripts/extract-cert
../scripts/extract-cert.c:21:25: fatal error: openssl/bio.h: No such file or directory
compilation terminated.



Regardless, I take your opinion as valid.


Chris
