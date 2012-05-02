From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 15:22:15 +0800
Subject: [PATCH 02/17] ARM: at91: use machine specific hook for late init
In-Reply-To: <20120502025144.GA19477@game.jcrosoft.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <20120428053001.GY9142@game.jcrosoft.org>
 <20120428065348.GC9924@S2101-09.ap.freescale.net>
 <201204300846.41118.arnd@arndb.de>
 <20120502025144.GA19477@game.jcrosoft.org>
Message-ID: <20120502072212.GY2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 04:51:44AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> I'll send a patch for soc_desc and conditional initcall
> will see which Russell prefer.
> 
Hmm, it seems you haven't answered my question about soc_desc.  With
DT adopted, machine_desc actually becomes the equivalent of soc_desc.
Why do we need soc_desc then?

-- 
Regards,
Shawn
