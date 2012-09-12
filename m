From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 12 Sep 2012 09:50:13 +0000
Subject: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing calculation
In-Reply-To: <20120911184606.GN23092@atomide.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com> <20120911184606.GN23092@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Sep 12, 2012 at 00:16:06, Tony Lindgren wrote:

> Here are the timing changes with and without this patch from
> my n800. You can just diff the two files to see some differences.

Hmm.. that was pretty close, OneNAND async,sync as well as
tusb sync values were same.

But some of the tusb async values is less by one. I need
to get it right.

And thanks for sending me the easily diff-able logs.

Regards
Afzal
