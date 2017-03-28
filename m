From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 28 Mar 2017 21:33:18 +0200
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: change switch2 label
In-Reply-To: <20170328192426.13798-1-vivien.didelot@savoirfairelinux.com>
References: <20170328192426.13798-1-vivien.didelot@savoirfairelinux.com>
Message-ID: <20170328193318.GG2268@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 03:24:26PM -0400, Vivien Didelot wrote:
> Rename the switch2 at 0 label of the switch2 node to switch at 0 to respect
> the general unit at address DTS rule, and be consistent with the other
> switch nodes of the DTS file.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Hi Vivien

You might need to rebase this onto

git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git

There have been a few other changes to the ZII dts files this cycle.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
