From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 21 Jun 2012 15:55:21 +0400
Subject: [PATCH 1/2] ARM: OMAP: USB: Fixup ehci_hcd_omap_probe error path
In-Reply-To: <1340275473-16374-1-git-send-email-Russ.Dill@ti.com>
References: <CA+Bv8XZ-g26_3Hv9xgDvwRooUeZwaKtZJwvnxxEZHcFx06es7Q@mail.gmail.com>
 <1340275473-16374-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <4FE30BA9.1070108@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-06-2012 14:44, Russ Dill wrote:

> A recent commit, [PATCH] Fix OMAP EHCI suspend/resume failure
> (i693) '354ab856'

    Usually commit ID follows the word "commit", and then the commit summary.

> causes ehci probe to fail on omap3xxx. This
> exposed bugs in the ehci_hcd_omap_probe error path causing
> an oops.

> On the error path, call usb_remove_hcd if usb_add_hcd has been
> called, and call usb_put_hcd if usb_alloc_hcd has been called.

> Tested on BB-xM.

> Signed-off-by: Russ.Dill at ti.com

    It should be:

Signed-off-by: Russ Dill <Russ.Dill@ti.com>

WBR, Sergei
