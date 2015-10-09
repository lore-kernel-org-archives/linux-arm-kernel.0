From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Oct 2015 22:22:40 +0800
Subject: [PATCH v3 3/5] ARM: sun5i: dt: Move uart3 pinctrl node to common
 DTSI
In-Reply-To: <1444380177-15302-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444380177-15302-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v656+cD__KkFASQ=dPkzE-d2OPoxzU94-yyA8+Y6XQmhiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 4:42 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The uart3 pins are shared between the A10s and A13, move the pinctrl node
> to the common DTSI to avoid duplication.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks
