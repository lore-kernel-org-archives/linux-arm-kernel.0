From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 17 Jan 2015 20:18:37 +0100
Subject: [PATCH 1/3] USB: host: ehci_atmel: Move global variables to
 private struct
In-Reply-To: <1421519013-22123-1-git-send-email-sylvain.rochet@finsecur.com>
References: <20150117160304.GA21820@gradator.net>
 <1421519013-22123-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150117201837.0784fb26@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On Sat, 17 Jan 2015 19:23:31 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> This patch move Atmel EHCI global variables (clocks ptr and clocked
> boolean) to private struct atmel_ehci, appended at the end of the parent
> struct usb_hcd.

Maybe you should add a cover letter to clearly state that this series
depends on another one: [1].

Anyway, thanks for removing these global variables.

> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

To the whole series:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

[1]https://www.mail-archive.com/linux-usb at vger.kernel.org/msg54675.html


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
