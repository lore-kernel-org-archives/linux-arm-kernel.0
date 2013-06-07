From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 17:30:14 +0200
Subject: [RFC PATCH 02/50] ARM: at91: add PMC main clock
In-Reply-To: <1370615115-16979-3-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370615115-16979-3-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130607173014.7186ddc0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Boris BREZILLON,

On Fri,  7 Jun 2013 16:24:10 +0200, Boris BREZILLON wrote:

> + * This mainram is free software; you can redistribute it and/or modify

Looks like you did some funky 'sed' over your source files. In every
clk driver, instead of "program" you have "<name of clock>ram" :-)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
