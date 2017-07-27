From: bp@alien8.de (Borislav Petkov)
Date: Thu, 27 Jul 2017 15:15:15 +0200
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170727090856.GB15784@hc>
References: <20170726154515.GA11453@hc> <20170726155548.GF28875@nazgul.tnic>
 <20170726161949.GB15426@kroah.com>
 <20170726163049.GG28875@nazgul.tnic>
 <20170726173353.GB21705@kroah.com>
 <1a2eedea-040d-c746-eaf0-1d8085b3f2bf@gmail.com>
 <20170726200802.GA17722@kroah.com>
 <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
 <20170727051157.GA4525@nazgul.tnic> <20170727090856.GB15784@hc>
Message-ID: <20170727131515.GC28548@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 11:08:56AM +0200, Jan Glauber wrote:
> OK. As fixing the firmware will take quite some time I'll go for the memory
> controller driver that starts EDAC / PMU depending on their CONFIG_.
> 
> What would be the proper location for the multiplexer?
> drivers/soc/cavium or drivers/misc?

Uff, no idea. Greg? You're the special drivers guy. :-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
