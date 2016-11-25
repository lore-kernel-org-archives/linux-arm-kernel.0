From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 18:05:06 +0800
Subject: [PATCH 07/10] ARM: dts: sun8i-a33-olinuxino: use AXP223 DTSI
In-Reply-To: <20161125090921.23138-8-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-8-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v67d6ZidMmftyU+4YEZgMxu+wJWmwNxevB5PLH2Wh4FFVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Previously, the Olimex A33-OlinuXino used everything declared in AXP221
> DTSI while it has an AXP223 PMIC.
>
> This corrects that so the Olimex A33-OlinuXino can get some features the
> AXP223 has (at the moment, ability to have 100mA as maximal current on
> VBUS power supply).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
