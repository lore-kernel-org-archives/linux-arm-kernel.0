From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 May 2014 17:30:20 +0200
Subject: [PATCH v5 5/5] ARM: sunxi: select MFD_SUN6I_PRCM when sun6i arch
 support is enabled
In-Reply-To: <1400144113-27659-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1400144113-27659-1-git-send-email-boris.brezillon@free-electrons.com>
 <1400144113-27659-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140515153020.GY29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 10:55:13AM +0200, Boris BREZILLON wrote:
> Select the MFD_SUN6I_PRCM option when sun6i arch is enabled in order to get
> the PRCM (Power/Reset/Clock Management) related drivers compiled.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/7123bcf6/attachment.sig>
