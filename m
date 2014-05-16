From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 May 2014 15:54:22 -0700
Subject: [PATCH v2] ARM: rockchip: convert smp bringup to
 CPU_METHOD_OF_DECLARE
In-Reply-To: <155552153.z5UXrbJMBi@phil>
References: <1632873.urGeGsUMPH@diego> <2151573.evmqdkWnet@diego>
 <1878147.CvhHSZhTas@diego> <155552153.z5UXrbJMBi@phil>
Message-ID: <20140516225422.GA6028@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 07:17:46PM +0200, Heiko St?bner wrote:
> Am Donnerstag, 27. M?rz 2014, 01:06:32 schrieb Heiko St?bner:
> > With the newly introduced CPU_METHOD_OF_DECLARE is not necessary anymore
> > to reference the relevant smp_ops in the board file, but instead it can
> > simply be set by the enable-method property of the cpu nodes.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> more responses to this? [or maybe even an ack :-) ? ]

Looks reasonable to me:

Acked-by: Olof Johansson <olof@lixom.net>
