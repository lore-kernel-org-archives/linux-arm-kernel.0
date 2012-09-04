From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 3 Sep 2012 22:47:51 -0700
Subject: [PATCH] ARM: dts: OMAP4: Cleanup and move GIC outside of the OCP
 node
In-Reply-To: <5044D8E5.5010705@ti.com>
References: <5044D8E5.5010705@ti.com>
Message-ID: <CAMQu2gz7M7zWogTdCtR6K3n-9CPoLf7NO4a314WmKhN-BeXCiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2012 at 9:20 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> Remove a useless comment and move GIC controller outside
> of the OCP node since it does use the MPU internal bus and
> not the OCP.
> This will not change the functionality but will reflect the
> reality more accurately.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
>
Make sense.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
