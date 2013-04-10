From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 10 Apr 2013 20:09:30 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: PM: fix PM regression introduced by recent
 clock cleanup
In-Reply-To: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1304102007030.25123@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Feb 2013, Paul Walmsley wrote:

> First, I missed the retention entry failure in the branch test logs:
> 
> http://www.pwsan.com/omap/testlogs/cleanup_a_3.9/20130126014242/pm/4460pandaes/4460pandaes_log.txt

Just a brief note.  For the past few -rc releases, have switched here to 
using scripts that parse the PM result logs, for PM validation.

The scripts are probably not perfect, but they're less likely to miss the 
cases they're set up to test.


- Paul
