From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 26 Feb 2018 16:21:48 +0100
Subject: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
In-Reply-To: <20180221085541.14556-5-a.hajda@samsung.com>
References: <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
 <20180221085541.14556-1-a.hajda@samsung.com>
 <20180221085541.14556-5-a.hajda@samsung.com>
Message-ID: <CAJKOXPczu67vPQEzQZvFRZGVNBpk0U6GJhSnb4dYWSgTY+Unog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 9:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v4:
> - added missing reg property in connector's port node (Krzysztof)
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)

You have a duplicated '};' so kbuild complains so I assume there will
be next iteration of this. Beside that I am okay with both, so I will
take next version when your bindings and driver changes get
acked/accepted.

Best Regards,
Krzysztof
