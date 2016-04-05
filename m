From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 Apr 2016 12:35:26 +0200
Subject: [v7, 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
In-Reply-To: <1459480051-3701-5-git-send-email-yangbo.lu@nxp.com>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
 <1459480051-3701-5-git-send-email-yangbo.lu@nxp.com>
Message-ID: <20160405103526.GG17838@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 11:07:30AM +0800, Yangbo Lu wrote:
> Move mpc85xx.h to include/linux/fsl and rename it to svr.h as
> a common header file. It has been used for mpc85xx and it will
> be used for ARM-based SoC as well.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Joerg Roedel <jroedel@suse.de>
