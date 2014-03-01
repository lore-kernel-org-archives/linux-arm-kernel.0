From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 1 Mar 2014 15:29:54 +0100
Subject: [PATCH v3 04/20] ARM: shmobile: r8a7779: Add clocks
In-Reply-To: <1393400016-23433-5-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-5-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140301142954.GB4307@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 04:33:20PM +0900, Simon Horman wrote:
> Declare all core and MSTP clocks currently used by r8a7779-based boards.
> 
> Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I wonder if patches 2-4 shouldn't be squashed? I think it would make
reviewing/finding typos easier.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140301/8772ffa3/attachment-0001.sig>
