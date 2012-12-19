From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Dec 2012 17:04:08 -0200
Subject: [PATCH 2/2] mxc: enable EHCI PER clock
In-Reply-To: <1355941777-99352-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1355941777-99352-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1355941777-99352-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <CAOMZO5DzoCsVZY-2Zzoxd0ACGKaryzoMtg8qPm+ttriNQvR9Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 4:29 PM, Gwenhael Goavec-Merou
<gwenhael.goavec-merou@armadeus.com> wrote:
> EHCI PER clock (aka usb_div) must be enabled to have EHCI driver working.
>
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Have you considered to use the chipidea usb driver in mx27 instead?
mx28/mx6 are already converted to the chipidea usb driver.

Regards,

Fabio Estevm
