From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 18 May 2011 14:40:22 +0400
Subject: [PATCH 8/9] davinci: remove definition of SRAM_VIRT
In-Reply-To: <8739469073d138fef7df16207644e94953e3f7cf.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>	<cover.1305668470.git.bengardiner@nanometrics.ca>
	<8739469073d138fef7df16207644e94953e3f7cf.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <4DD3A216.9040906@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-05-2011 1:42, Ben Gardiner wrote:

> Previously all platforms were iomapping their SRAM using iotable entries with
> SRAM_VIRT as the target virtual address.

> Remove the SRAM_VIRT definition now that all the iotables are removed and
> sram init is doing ioremaps before regsitering with pv_pool_create.

> Signed-off-by: Ben Gardiner<bengardiner@nanometrics.ca>

    I think patches 3-8 can safely be merged into one patch.

WBR, Sergei
