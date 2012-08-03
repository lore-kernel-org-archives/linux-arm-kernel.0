From: cjb@laptop.org (Chris Ball)
Date: Fri, 03 Aug 2012 19:52:51 -0400
Subject: [PATCH v3 2/9] MMC: pxa-mci: add DT bindings
In-Reply-To: <1343470061-16879-3-git-send-email-zonque@gmail.com> (Daniel
 Mack's message of "Sat, 28 Jul 2012 12:07:34 +0200")
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <1343470061-16879-3-git-send-email-zonque@gmail.com>
Message-ID: <87k3xf354c.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jul 28 2012, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <cjb@laptop.org>
> ---
>  Documentation/devicetree/bindings/mmc/pxa-mmc.txt | 25 +++++++++++
>  drivers/mmc/host/pxamci.c                         | 52 +++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/pxa-mmc.txt

Mind if I merge this via the MMC tree?  I prefer to take MMC patches
there, and it doesn't look like there are any dependencies involved.
I've pushed it to mmc-next now.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
