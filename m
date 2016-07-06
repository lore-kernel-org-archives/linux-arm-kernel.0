From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 Jul 2016 09:34:14 +0200
Subject: [PATCH 6/7] dt-bindings: net: bgmac: add bindings documentation
 for bgmac
In-Reply-To: <CAC3K-4qZ9tpEAuDBjL-bkjn5F2Xfr4CAmVGc=DpgVh8MrqEDtQ@mail.gmail.com>
References: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
 <3327458.KVBg7y9SeP@wuerfel>
 <CAC3K-4qZ9tpEAuDBjL-bkjn5F2Xfr4CAmVGc=DpgVh8MrqEDtQ@mail.gmail.com>
Message-ID: <13160704.EGDxD1URaF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 5, 2016 7:18:45 PM CEST Jon Mason wrote:
> >
> > Ok, then I'd suggest making the compatible string here
> >
> >         compatible = "brcm,nsp-amac", "brcm,amac";
> 
> It is called GMAC in the NS and NSP documentation, but AMAC is fine
> with me (as it is called this in the NS2 documentation).  I'll make
> the necessary change and repush.

Ok, then we can use

	compatible = "brcm,nsp-gmac", "brcm,amac";

to be consistent with that documentation and have the generic name as the
fallback.

	Arnd
