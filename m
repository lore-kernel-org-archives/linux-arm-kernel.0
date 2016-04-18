From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 18 Apr 2016 07:11:46 +0200
Subject: [PATCH v1] ARM: dts: omap3-n900: Specify peripherals LDO
 regulators initial mode
In-Reply-To: <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20160417122933.GA8093@earth>
 <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160418051146.GA3215@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Apr 17, 2016 at 05:29:23PM +0300, Ivaylo Dimitrov wrote:
> Without that, regulators are left in the mode last set by the bootloader or
> by the kernel the device was rebooted from. This leads to various problems,
> like non-working peripherals.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160418/1b76b54a/attachment.sig>
