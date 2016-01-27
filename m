From: sre@ring0.de (Sebastian Reichel)
Date: Thu, 28 Jan 2016 00:47:47 +0100
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
In-Reply-To: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160127234746.GA3227@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 10, 2016 at 07:46:30PM +0200, Ivaylo Dimitrov wrote:
> Add linux,can-disable; to all gpios exported from gpio-keys driver, so
> userspace can disable them
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/c7ea412b/attachment.sig>
