From: linville@tuxdriver.com (John W. Linville)
Date: Tue, 15 Jul 2014 16:58:41 -0400
Subject: [PATCH v4 0/4] brcmfmac: OOB interrupt support
In-Reply-To: <1404051421-24377-1-git-send-email-hdegoede@redhat.com>
References: <1404051421-24377-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140715205841.GG26012@tuxdriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "brcmfmac: Cleanup used device IDs." makes this series
not build.  Unfortunately, I already merged that one...

Would you mind rebasing/reposting this?

Sorry...

John

On Sun, Jun 29, 2014 at 04:16:57PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of the brcmfmac: OOB interrupt support series.
> 
> Changes since v1:
> -Post as a stand alone series, rather then together with sunxi pinctrl changes,
>  etc.
> -Add a patch to fixup the names of the register addresses used in the
>  "brcmfmac: Fix OOB interrupt not working for BCM43362" patch
> -Use the new register names in:
>  "brcmfmac: Fix OOB interrupt not working for BCM43362"
> 
> Changes since v2:
> -"dt: bindings: add bindings for Broadcom bcm43xx sdio devices"
>  * changed the compatible string to brcm,bcm4329-fmac
>  * replaced the dt-bindings example with a real world example
> -"brcmfmac: Fix OOB interrupt not working for BCM43362"
>  * updated commit message with confirmation from broadcom that this is the
>    right thing to do
> 
> Regards,
> 
> Hans
> 

-- 
John W. Linville		Someday the world will need a hero, and you
linville at tuxdriver.com			might be all we have.  Be ready.
