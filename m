From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 2 Mar 2015 19:15:51 +0100
Subject: [PATCH] ARM: at91: pm: fix SRAM allocation
In-Reply-To: <CBAD3087-CD3D-4101-B001-D0140A46E12B@jcrosoft.com>
References: <1425292978-28135-1-git-send-email-alexandre.belloni@free-electrons.com>
 <7E7AE962-1BBE-4B33-9563-B91351494005@jcrosoft.com>
 <20150302105736.GL4094@piout.net>
 <CBAD3087-CD3D-4101-B001-D0140A46E12B@jcrosoft.com>
Message-ID: <20150302181551.GV4094@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 at 00:14:57 +0800, Jean-Christophe PLAGNIOL-VILLARD wrote :
> >> pdev not initialised at NULL
> > 
> > Indeed, I'll fix that. It doesn't really matter for now as all the
> > at91 DT have at least one sram node.
> except if we drop it or when we add a new SoC and forget it
> 

Sure, I was just saying that it doesn't matter for test purposes. It
will be fixed in v2. I just want to make sure it is also working on g20
before sending it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
