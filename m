From: bp@alien8.de (Borislav Petkov)
Date: Thu, 27 Jul 2017 07:11:57 +0200
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
References: <20170726151314.GA10696@hc> <20170726153502.GE28875@nazgul.tnic>
 <20170726154515.GA11453@hc> <20170726155548.GF28875@nazgul.tnic>
 <20170726161949.GB15426@kroah.com>
 <20170726163049.GG28875@nazgul.tnic>
 <20170726173353.GB21705@kroah.com>
 <1a2eedea-040d-c746-eaf0-1d8085b3f2bf@gmail.com>
 <20170726200802.GA17722@kroah.com>
 <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
Message-ID: <20170727051157.GA4525@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 02:02:42PM -0700, David Daney wrote:
> Also, if a given configuration disables CONFIG_EDAC there is some hackery
> needed to get the perf portion of the driver included.

Yes, and we don't do performance counters in EDAC.

So you could add a small memory controller driver which does the
arbitration or fix the firmware.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
