From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 26 Nov 2016 16:07:21 +0100
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.10, round 2
In-Reply-To: <m2k2btx2c9.fsf@baylibre.com>
References: <m2k2btx2c9.fsf@baylibre.com>
Message-ID: <CAFBinCAvziwM4U6qJnTV+nEMKaZH4G9xdTM0pY6O83+Edk=Ovw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Nov 23, 2016 at 11:23 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Arnd, Olof,
>
> Here's a final round of arm64 DT changes for Amlogic family SoCs.
please note that SCPI is not working due to a change in Sudeep's
repository which has not made it into the Amlogic tree yet:
Sudeep's latest pull request indicates that we should use
"arm,scpi-pre-1.0", while currently we are only using
"amlogic,meson-gxbb-scpi": [0]
I fixed that in the Amlogic .dts files in [1] but this patch has not
been applied yet.

No pressure on this one - I just want to save your time (so you don't
have to search why SCPI is not working anymore)


Regards,
Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001632.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001665.html
