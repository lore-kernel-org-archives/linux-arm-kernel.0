From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Apr 2018 17:06:17 +0800
Subject: [PATCH v5 09/13] ARM: sun9i: smp: Rename clusters's power-off
In-Reply-To: <20180403061836.3926-10-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-10-mylene.josserand@bootlin.com>
Message-ID: <CAGb2v67n8DzqOJWAaWGpdb2-AS0UM+_+qFZCt4_Dzb4+ySTcRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 2:18 PM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> To prepare the support for sun8i-a83t, rename the variable name
> that handles the power-off of clusters because it is different from
> sun9i-a80 to sun8i-a83t.
>
> The power off register for clusters are different from a80 and a83t.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
