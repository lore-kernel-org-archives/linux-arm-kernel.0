From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Jun 2016 15:31:16 +0200
Subject: [PATCH] ARM: orion: remove unreferenced board-d2net.c
In-Reply-To: <1465466656-30002-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465466656-30002-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160609133116.GH30205@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 11:04:16AM +0100, Ben Dooks wrote:
> Either this has been mis-converted (and needs to be fixed) or
> is no longer referenced and can be safely removed.

Hi Thomas

You added this code, which Ben is removing. It does look like you
forgot to call d2net_init() from orion5x_dt_init().

Please could you look at this.

       Thanks
  	Andrew
