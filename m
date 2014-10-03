From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 3 Oct 2014 17:17:24 +0200
Subject: [PATCH 2/2] net: spider_net: avoid using signed char for bitops
In-Reply-To: <9201792.OAu7xPjvdN@wuerfel>
References: <1412348517-20352-1-git-send-email-antoine.tenart@free-electrons.com>
 <1412348517-20352-4-git-send-email-antoine.tenart@free-electrons.com>
 <9201792.OAu7xPjvdN@wuerfel>
Message-ID: <20141003151724.GB20398@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Oct 03, 2014 at 05:15:05PM +0200, Arnd Bergmann wrote:
> On Friday 03 October 2014 17:01:56 Antoine Tenart wrote:
> > Signedness bugs may occur when using signed char for bitops,
> > depending on if the highest bit is ever used.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > 
> 
> It's probably worth mentioning here that this cannot happen in this
> driver because it's only used in one powerpc-specific chip, and 'char'
> is always 'unsigned' on powerpc.

Oh, that's good to know :)


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
