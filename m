From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 May 2015 12:13:42 +0200
Subject: [PATCH 4/6] dmaengine: sun6i: Add support for Allwinner H3
 (sun8i) variant
In-Reply-To: <1430904693-1404-5-git-send-email-jenskuske@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-5-git-send-email-jenskuske@gmail.com>
Message-ID: <20150506101342.GC11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:31:31AM +0200, Jens Kuske wrote:
> The H3 SoC has the same dma engine as the A31 (sun6i), with a
> reduced amount of endpoints and physical channels. Add the proper
> config data and compatible string to support it.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/e9f37fc3/attachment-0001.sig>
