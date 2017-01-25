From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 09:11:13 +0100
Subject: [PATCH] ARM: tegra: paz00: fix __initdata placement
In-Reply-To: <20170123074347.GA29804@dtor-ws>
References: <20170123074347.GA29804@dtor-ws>
Message-ID: <20170125081113.GD13025@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 11:43:47PM -0800, Dmitry Torokhov wrote:
> To have expected effect the __initdata attribute should go after variable
> name and before initializer.`
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/arm/mach-tegra/board-paz00.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with an updated commit message.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/df9c6362/attachment.sig>
