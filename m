From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Nov 2011 15:20:17 +0000
Subject: [PATCH v2 0/4] Versatile Express DT support
In-Reply-To: <4ED399C8.9080908@gmail.com>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <4ED399C8.9080908@gmail.com>
Message-ID: <1322493617.3164.56.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-28 at 14:25 +0000, Rob Herring wrote:
> Other than Dave's comments, looks good. For the series:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks!

> There are a number of compatible strings for various peripherals defined
> without documentation, but you're not really using them so I think it's
> fine for now. BTW, I believe Dave said he was going to document some of
> the primecell peripherals. :)

Yep, we agreed with Dave that the ones I'll take care of soon are MMCI
(PL180) and the VE sysregs, the rest is his :-)

On that subject - some time ago I sent a patch adding "sil" vendor
string, as this one the only non-documented one I used:

http://article.gmane.org/gmane.linux.drivers.devicetree/9362/

Cheers!

Pawe?
