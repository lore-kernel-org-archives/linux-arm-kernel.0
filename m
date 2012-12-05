From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 5 Dec 2012 09:45:03 +0800
Subject: [PATCH 1/2] i2c-core: dt: Pick i2c bus number from i2c alias if
 present
In-Reply-To: <1353522362-25519-2-git-send-email-dianders@chromium.org>
References: <1353450428-2615-2-git-send-email-dianders@chromium.org>
 <1353522362-25519-1-git-send-email-dianders@chromium.org>
 <1353522362-25519-2-git-send-email-dianders@chromium.org>
Message-ID: <CAN1soZyqWk07dqWUmdoknTjw7co8KJLgkO3RT+YY-4QxPg5zdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 2:26 AM, Doug Anderson <dianders@chromium.org> wrote:
> This allows you to get the equivalent functionality of
> i2c_add_numbered_adapter() with all data in the device tree and no
> special case code in your driver.  This is a common device tree
> technique.
>
> For quick reference, the FDT syntax for using an alias to provide an
> ID looks like:
>   aliases {
>     i2c0 = &i2c_0;
>     i2c1 = &i2c_1;
>   };
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> ---
>  drivers/i2c/i2c-core.c |  105 +++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 77 insertions(+), 28 deletions(-)
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
