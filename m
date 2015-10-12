From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 12 Oct 2015 11:25:54 -0700
Subject: [PATCH v2] PM / AVS: rockchip-io: Fix module autoload for OF
 platform driver
In-Reply-To: <1443796077-24722-1-git-send-email-luisbg@osg.samsung.com> (Luis
 de Bethencourt's message of "Fri, 2 Oct 2015 15:27:57 +0100")
References: <1443796077-24722-1-git-send-email-luisbg@osg.samsung.com>
Message-ID: <7hlhb8djv1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Luis de Bethencourt <luisbg@osg.samsung.com> writes:

> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Kevin Hilman <khilman@linaro.org>

Rafael, feel free to apply directly.

Kevin
