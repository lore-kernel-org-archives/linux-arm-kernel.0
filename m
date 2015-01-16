From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Jan 2015 17:20:52 +0100
Subject: [PATCHv2 3/3] ARM: mvebu: use arm_coherent_dma_ops and
 re-enable hardware I/O coherency
In-Reply-To: <20150116161548.GD17658@lunn.ch>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1421424689-5971-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150116161548.GD17658@lunn.ch>
Message-ID: <20150116172052.72ea2c32@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 16 Jan 2015 17:15:48 +0100, Andrew Lunn wrote:

> In patch 1/3 you add a comment here saying why you have turned it off.
> This hunk turns it back on again. But i don't see the comment being
> removed?

Stupid mistake, indeed :-/

Do you want a v3, or can you kill the comment when applying the patch?

Thanks, and sorry about this,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
