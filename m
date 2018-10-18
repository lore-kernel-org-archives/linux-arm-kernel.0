From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 18 Oct 2018 11:55:22 -0300
Subject: [PATCH] ARM: dts: imx: Add missing stdout-path property
In-Reply-To: <20181018145128.21117-1-shyam.saini@amarulasolutions.com>
References: <20181018145128.21117-1-shyam.saini@amarulasolutions.com>
Message-ID: <CAOMZO5Di60q+ma2ASe-PbSitAPMEBvWN1Sa2uQY6CKN6rEkSgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 11:52 AM Shyam Saini
<shyam.saini@amarulasolutions.com> wrote:
>
> This would help us to get early boot logs by passing "earlycon" to
> kernel bootargs.
>
> Further, by adding this we don't have to depend on complex earlyprintk
> configs for early boot logs.
>
> Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>

In the Subject please mention the board name:

ARM: dts: imx6qdl-icore: Add missing stdout-path property

With this change in place then you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
