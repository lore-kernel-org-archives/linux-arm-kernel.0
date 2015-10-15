From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 15 Oct 2015 02:35:39 +0200
Subject: [PATCH v2] PM / AVS: rockchip-io: Fix module autoload for OF
 platform driver
In-Reply-To: <7hlhb8djv1.fsf@deeprootsystems.com>
References: <1443796077-24722-1-git-send-email-luisbg@osg.samsung.com>
 <7hlhb8djv1.fsf@deeprootsystems.com>
Message-ID: <3694102.oARWiAFOaH@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 12, 2015 11:25:54 AM Kevin Hilman wrote:
> Luis de Bethencourt <luisbg@osg.samsung.com> writes:
> 
> > This platform driver has a OF device ID table but the OF module
> > alias information is not created so module autoloading won't work.
> >
> > Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> Rafael, feel free to apply directly.

Done.

Thanks,
Rafael
