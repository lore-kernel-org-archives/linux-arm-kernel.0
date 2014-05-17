From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 17 May 2014 02:16:10 +0200
Subject: [PATCH v2] ARM: rockchip: convert smp bringup to
 CPU_METHOD_OF_DECLARE
In-Reply-To: <20140516225422.GA6028@quad.lixom.net>
References: <1632873.urGeGsUMPH@diego> <155552153.z5UXrbJMBi@phil>
 <20140516225422.GA6028@quad.lixom.net>
Message-ID: <21547723.QIMYqQcA8Y@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Am Freitag, 16. Mai 2014, 15:54:22 schrieb Olof Johansson:
> On Mon, May 12, 2014 at 07:17:46PM +0200, Heiko St?bner wrote:
> > Am Donnerstag, 27. M?rz 2014, 01:06:32 schrieb Heiko St?bner:
> > > With the newly introduced CPU_METHOD_OF_DECLARE is not necessary anymore
> > > to reference the relevant smp_ops in the board file, but instead it can
> > > simply be set by the enable-method property of the cpu nodes.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > more responses to this? [or maybe even an ack :-) ? ]
> 
> Looks reasonable to me:
> 
> Acked-by: Olof Johansson <olof@lixom.net>

or you could simply apply it to arm-soc directly :-)

Because apart from the pull request I sent two days ago, this patch looks like 
the last one for 3.16 ... everything else needs to marture a bit longer.

Otherwise I'll send a pull-request for this one patch in the next days.


Heiko
