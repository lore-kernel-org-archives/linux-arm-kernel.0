From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 15:33:07 -0800
Subject: [GIT PULL] Allwinner DT changes for 3.14, take 2
In-Reply-To: <20140107231033.GA18548@lukather> (Maxime Ripard's message of
 "Wed, 8 Jan 2014 00:10:33 +0100")
References: <20140107231033.GA18548@lukather>
Message-ID: <87ha965ebw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Hi Arnd, Kevin, Olof,
>
> Please pull the following changes on top of the previous pull request.
>
> Thanks!
> Maxime
>
> The following changes since commit 81ee429ffdd021626bf191bb8a3ae886dd94adcc:
>
>   ARM: sun6i: dt: Add IP needed to bring up the additional cores (2013-12-16 21:15:12 +0100)
>
> are available in the git repository at:
>
>   https://github.com/mripard/linux.git tags/sunxi-dt-for-3.14-2
>
> for you to fetch changes up to 6267355f0e513bed9a5009924abc7a1e7de22ab3:
>
>   arm: sun7i: cubietruck: Enable the i2c controllers (2014-01-07 23:39:19 +0100)
>
> ----------------------------------------------------------------
> Second round of DT additions for 3.14
>
> Mostly:
>   - Addition of the missing PLLs and module clocks
>   - Addition of the external clocks
>   - Addition of the touchscreen controler
>   - I2C nodes of the Cubietruck
>
> ----------------------------------------------------------------

Applied to next/dt.

Thanks,

Kevin
