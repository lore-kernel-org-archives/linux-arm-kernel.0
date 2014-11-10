From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Nov 2014 13:45:48 +0000
Subject: [PATCH] ASoC: davinvi-mcasp: Balance pm_runtime_enable() on
 probe failure
In-Reply-To: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
References: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
Message-ID: <20141110134548.GR3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 06:15:14PM +0530, Anil Kumar wrote:
> If probe fails then we need to call pm_runtime_disable() to balance
> out the previous pm_runtime_enable() call.

applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/2fc8df86/attachment.sig>
