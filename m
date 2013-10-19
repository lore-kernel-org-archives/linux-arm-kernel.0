From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:36:56 +0000 (UTC)
Subject: [PATCH 11/11] ARM: OMAP2+: CM: move direct register write macros
 to internal header
In-Reply-To: <1381508141-15244-12-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-12-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191736190.12900@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> The direct register access macros should not be exposed to CM clients.
> Thus, move the register macros to their own file and only include these
> to the cm_*.c files.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

The basic idea here looks great, obviously we can't merge it yet...

- Paul
