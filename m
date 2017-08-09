From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 17:03:02 -0500
Subject: [PATCH] bus: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-11-robh@kernel.org>
References: <20170718214339.7774-11-robh@kernel.org>
Message-ID: <CAL_JsqJv6U9Pj05rrTsW04MXJGVS7K3b=oRZZ023vXmcLZXzFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 4:42 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/bus/arm-cci.c   | 12 ++++++------
>  drivers/bus/imx-weim.c  |  8 ++++----
>  drivers/bus/sunxi-rsb.c | 22 +++++++++++-----------
>  3 files changed, 21 insertions(+), 21 deletions(-)

Arnd, Olof,

Can you please apply this one.

Rob
