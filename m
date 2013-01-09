From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 Jan 2013 13:54:07 -0500 (EST)
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <201301091843.48942.arnd@arndb.de>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <201301091843.48942.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1301091349390.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013, Arnd Bergmann wrote:

> On a related topic, I still think we should fix ARCH_MULTI_V7 not
> to select ARCH_VEXPRESS unconditionally and come up with a better
> way to avoid having an empty platform list to make 'allnoconfig'
> still work.

The virtual guest platform support that Will and Marc did is small 
enough that it could always be selected in place of vexpress.


Nicolas
