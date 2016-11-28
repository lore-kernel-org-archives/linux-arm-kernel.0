From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 28 Nov 2016 10:27:10 -0800
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.10, round 2
In-Reply-To: <CAFBinCAvziwM4U6qJnTV+nEMKaZH4G9xdTM0pY6O83+Edk=Ovw@mail.gmail.com>
 (Martin Blumenstingl's message of "Sat, 26 Nov 2016 16:07:21 +0100")
References: <m2k2btx2c9.fsf@baylibre.com>
 <CAFBinCAvziwM4U6qJnTV+nEMKaZH4G9xdTM0pY6O83+Edk=Ovw@mail.gmail.com>
Message-ID: <m2fumbtq81.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Kevin,
>
> On Wed, Nov 23, 2016 at 11:23 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Arnd, Olof,
>>
>> Here's a final round of arm64 DT changes for Amlogic family SoCs.
> please note that SCPI is not working due to a change in Sudeep's
> repository which has not made it into the Amlogic tree yet:
> Sudeep's latest pull request indicates that we should use
> "arm,scpi-pre-1.0", while currently we are only using
> "amlogic,meson-gxbb-scpi": [0]

Yes, I had to drop that legacy compatible as it was still under
discsussion.  Now that it's agreed upon, I've just sent a patch to fix
that.

> I fixed that in the Amlogic .dts files in [1] but this patch has not
> been applied yet.
>
> No pressure on this one - I just want to save your time (so you don't
> have to search why SCPI is not working anymore)

Thanks!

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470842.html
