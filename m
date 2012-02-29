From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 29 Feb 2012 09:51:56 -0700 (MST)
Subject: [PATCHv3 2/4] ARM: OMAP4: prm: fix interrupt register offsets
In-Reply-To: <1330529106-10423-3-git-send-email-t-kristo@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
 <1330529106-10423-3-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1202290951460.10984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Feb 2012, Tero Kristo wrote:

> Previous code used wrong instance for the interrupt register access.
> Use the right one which is OCP_SOCKET.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued.


- Paul
