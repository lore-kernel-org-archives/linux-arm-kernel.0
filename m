From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 16:37:01 -0700
Subject: [PATCHv6 0/6] ARM: sofpga: Add SD/MMC, clk-gate, and fix
 ethernet bindings
In-Reply-To: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
References: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130611233701.GF23774@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 10:02:52AM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Hi Arnd/Olof,
> 
> Can you please apply this patch series? Patch 3/6 has gotten Mike Turquette's Ack.
> The SD/MMC patches have been reviewed by Seungwon Jeon, Jaehoon Chung and Arnd.
> 
> Sorry, forgot to cc Arnd/Olof directly.

Hi,

I have applied patches 1-4, the first two to next/dt, the latter to next/soc.

See comments on patch 5 and 6. I don't expect either to be controversial, but
please repost them with the needed cc:s just in case -- there's still some time
to get it in for 3.11. In particular patch 6 should be applied by Chris Ball to
the MMC tree.


-Olof
