From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 15 Oct 2017 18:56:04 -0200
Subject: [PATCH 2/2] ARM: dts: imx6q-cm-fx6: Use the 'vpcie-supply'
 property
In-Reply-To: <5c38abed-4d13-4c7a-b4dc-eef54786e5d8@rwthex-s3-b.rwth-ad.de>
References: <1508098744-12099-1-git-send-email-festevam@gmail.com>
 <b26ee565-89d6-4feb-a639-b4e6482425b6@rwthex-w1-b.rwth-ad.de>
 <5c38abed-4d13-4c7a-b4dc-eef54786e5d8@rwthex-s3-b.rwth-ad.de>
Message-ID: <CAOMZO5B_f3K0i1wVVgqiTnt+vBxUfTbDrgGsyX=OZU-ZxRDWUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher ,

On Sun, Oct 15, 2017 at 6:46 PM, Christopher Spinrath
<christopher.spinrath@rwth-aachen.de> wrote:

> Unfortunately, this change breaks the PCI support on the Utilite (which
> is based on the cm-fx6). Without this change the regulator framework
> disables the pcie/vdd regulator and by doing so actually activates it
> (which is weird and should definitely be changed).
>
> With the following additional diff, which sets the correct polarity of
> the regulator, it works again:

Thanks, just sent v2 with the polarity fix.
