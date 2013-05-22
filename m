From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 May 2013 08:40:06 -0700
Subject: [PATCH 1/5] ARM: dts: OMAP2+: use #include for all device trees
In-Reply-To: <1369232864-14460-2-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130522154006.GB10378@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130522 07:33]:
> Replace /include/ by #include for OMAP2+ DT, in order to use the
> C pre-processor, making use of #define features possible.

This is good, but let's use it with case. Probably the best use
for this right now is to add defines for the mux modes from
mach-omap2/mux.h as that makes the raw values readable without
comments.

Regards,

Tony
