From: tony@atomide.com (Tony Lindgren)
Date: Sat, 7 Dec 2013 09:41:25 -0800
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <201312070552.34537.arnd@arndb.de>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312061741.33427.arnd@arndb.de>
 <CAL_JsqJmwPwVmNzibr8S-RH8ibwCzXVFMdJA-STPTHG+H0113w@mail.gmail.com>
 <201312070552.34537.arnd@arndb.de>
Message-ID: <20131207174125.GP26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [131206 20:54]:
> On Friday 06 December 2013, Rob Herring wrote:
> 
> From this list it is pretty clear that we want V6K as the default as you
> suggested, and I think we should eliminate any 'select CPU_V6K' except
> for OMAP2 (unless I made a mistake in my platform list). Maybe Tony has
> a better understanding of which OMAP2 systems are actually V6K or V6.

Yes both omap2420 and 2430 are just V6, not V6K.

Regards,

Tony
