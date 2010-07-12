From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 12 Jul 2010 14:21:01 -0600 (MDT)
Subject: [PATCH] OMAP2: powerdomain: Add break in switch statement
In-Reply-To: <1278661253-22185-1-git-send-email-weber@corscience.de>
References: <1278661253-22185-1-git-send-email-weber@corscience.de>
Message-ID: <alpine.DEB.2.00.1007121418220.10106@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Jul 2010, Thomas Weber wrote:

> Add a missing break at end of switch statement. At the moment it is a
> fall through to WARN_ON(1) and return -EEXIST.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>

Thanks Thomas.

Tony, this is

Acked-by: Paul Walmsley <paul@pwsan.com>

if you want it for .36; otherwise, can queue it for .37 here.


- Paul
