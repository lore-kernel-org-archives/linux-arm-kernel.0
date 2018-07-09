From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 09 Jul 2018 14:53:13 -0700
Subject: [PATCH RESEND] ARM64: dts: meson-axg: add the audio clock
 controller
In-Reply-To: <20180706144305.30116-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Fri, 6 Jul 2018 16:43:05 +0200")
References: <20180706144305.30116-1-jbrunet@baylibre.com>
Message-ID: <7h7em4nkja.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the audio clock controller which is part of the audio bus
> This controller takes 8 input plls, and the usual clock gate, from the
> main clock controller. It provides the clocs for the all the devices of
> the audio subsystem, such as tdms, spdif, pdm, etc.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
> Resend to fix typo reported by Martin in the commit description.
> (Thx Martin !)
>
> Kevin,
>
> Please note that this change depends on the axg audio clock bindings [0].
>
> It explains the problem reported by kbuild robot
> It will be part of our PR to clock in this cycle.
>
> As usual, I've prepared a topic branch with the DT changes for you.
> Please, let me know when you need a tag on it.

Unless you're expecting some more dependencies for the v4.19 cycle,
please tag it now, then I will queue it up.

Kevin
