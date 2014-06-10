From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jun 2014 13:47:52 +0200
Subject: [PATCH 0/2] ARM: topology: Allow to set the frequency through a
 clock
In-Reply-To: <1400700796-5763-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400700796-5763-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140610114752.GL9791@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 09:33:14PM +0200, Maxime Ripard wrote:
> Hi,
> 
> This patch series add the possibility for the topology code to get the
> CPU frequency through a DT clock handle instead of needing a
> clock-frequency property.
> 
> Indeed, this information can be quite redundant if the clock tree
> defined in the DT is already describing the CPU parent clock.

Ping?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140610/ef04c7d7/attachment.sig>
