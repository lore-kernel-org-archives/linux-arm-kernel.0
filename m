From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 18:06:13 +0800
Subject: [PATCH 10/10] ARM: dtsi: sun8i-reference-design-tablet: use
 AXP223 DTSI
In-Reply-To: <20161125090921.23138-11-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-11-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v667+RaspdFv5enrOdZRZs4wwJaSdSGntekrfYoYJJNE2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Previously, the sun8i tablets used everything declared in AXP221 DTSI
> while they have an AXP223 PMIC.
>
> This corrects that so the sun8i tablets can get some features the AXP223
> has (at the moment, ability to have 100mA as maximal current on VBUS
> power supply).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
