From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 29 May 2015 12:06:29 +0200
Subject: [PATCH 1/2] pinctrl: mvebu: Fix mapping of pin 63 (gpo -> gpio)
In-Reply-To: <1e014a41f99caee6f054713546efdf20@mail.ncrmnt.org>
References: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
 <1428784160-19431-2-git-send-email-andrew@ncrmnt.org>
 <20150529111002.7368ca50@free-electrons.com>
 <1e014a41f99caee6f054713546efdf20@mail.ncrmnt.org>
Message-ID: <20150529120629.1cb0d8ae@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Fri, 29 May 2015 12:55:44 +0300, Andrew wrote:

> Yep, exactly. I've seen that in the public docs. It must be a typo,
> unless there's something we don't know.
> 
> On DNS-327L this pin is wired as a button. Without th patch only
> gpio-buttons driver fails probing, but you can still configure the pin
> as input via sysfs gpio interface and even read sensible values from it.
> If you have a board where this pin is broken out - it's easy to test.

Ok, I've made a request for Marvell to check this aspect. If there's a
mistake, they should hopefully fix the datasheet at some point.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
