From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 13 Apr 2016 15:52:19 +0300
Subject: [PATCH 3/3] ARM: dts: am43xx: add support for clkout1 clock
In-Reply-To: <20160412210538.GB5995@atomide.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
 <1458158097-21137-4-git-send-email-t-kristo@ti.com>
 <20160412210538.GB5995@atomide.com>
Message-ID: <570E4103.2060301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2016 12:05 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [160316 12:55]:
>> clkout1 clock node and its generation tree was missing. Add this based
>> on the data on TRM and PRCM functional spec.
>
> Can I pick this one separately?

Yes it has no dependencies towards the other patches.

-Tero

>
> Tony
>
