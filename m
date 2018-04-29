From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 29 Apr 2018 15:47:24 +0200
Subject: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
In-Reply-To: <8012696a7bf0132dd2361a896bf0abfbe8a3084e.camel@paulk.fr>
References: <20180422142151.17910-1-contact@paulk.fr>
 <20180422143911.GB16141@n2100.armlinux.org.uk>
 <8012696a7bf0132dd2361a896bf0abfbe8a3084e.camel@paulk.fr>
Message-ID: <d167cc6987fdb7f04493c634873d430dcd216887.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le dimanche 22 avril 2018 ? 19:22 +0200, Paul Kocialkowski a ?crit :
> Are all CuBox-i units that have ever been sold supposed to have a
> connector with a CD line? I find it hard to believe that it's broken
> specifically on mine.

Do you have a clue whether there should, in fact, be a CD line on all
CuBox-i models out there? Although you seemed to imply that my device
might be broken, I am still confused about whether this issue concerns
my device only or a specific revision of the CuBox-i.

> If that's really needed, I could open up the device, check whether the
> R8 pull is in place and check the voltage there.

In case there is a doubt, I will proceed with opening the device so we
can have a clear idea, but I'd rather avoid it as much as possible.

Cheers,

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180429/e3eb8e16/attachment-0001.sig>
