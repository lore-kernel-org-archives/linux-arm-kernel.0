From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 6 Dec 2017 16:04:04 -0800
Subject: [PATCH 3/3] ARM64: dts: meson-axg: add the SPICC controller
In-Reply-To: <7hy3mfmmtd.fsf@baylibre.com>
References: <20171128132926.19051-1-yixun.lan@amlogic.com>
 <20171128132926.19051-4-yixun.lan@amlogic.com>
 <7hy3mfmmtd.fsf@baylibre.com>
Message-ID: <CAOi56cU0gQfCViSF=6o3uYKYaVi_Lwqwjiv_-Z6p1FFCPP1PMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 3:57 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
>
>> From: Sunny Luo <sunny.luo@amlogic.com>
>>
>> Add DT info for the SPICC controller which found in
>> the Amlogic's Meson-AXG SoC.
>>
>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>
> This patch looks OK but it doesn't apply cleanly.
>
> A quick glance suggests that it's becuase it has a dependency on the PWM
> series, but that dependency was not described here (or in the cover
> letter.)
>
> If the series does not apply directly on mainline, the cover letter
> should describe the dependencies clearly.
>
> In your case, I understand it's difficult because you have many series
> in parallel at the same time.  I would suggest that locally, you keep
> each series as independent branches based on the latest -rc tag.

Correction: while in general it's best to keep things based on the
latest -rc tag, for DT patches, it's even better if you base things on
my current <version>/dt64 branch (currently v4.16/dt64)

Kevin
