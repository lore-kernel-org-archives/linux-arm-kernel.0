From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 27 Mar 2015 00:47:39 +0100
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <871tkbxwup.fsf@free.fr>
References: <20150216130549.GF14545@x1>
 <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
 <20150216162712.GR14545@x1> <87fva5a4i2.fsf@free.fr>
 <20150217074310.GT14545@x1>
 <alpine.LFD.2.11.1502171221300.22104@knanqh.ubzr>
 <20150218080719.GB5781@x1> <87a9088tam.fsf@free.fr>
 <20150325140725.GA11499@kroah.com> <871tkbxwup.fsf@free.fr>
Message-ID: <20150326234739.GA28519@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 10:38:54PM +0100, Robert Jarzmik wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Feb 20, 2015 at 05:02:57PM +0100, Robert Jarzmik wrote:
> >> If there is no solution, I'll fallback through arch/arm/plat-pxa, not very nice,
> >> but it has to land somewhere, I don't want lubbock to remain broken.
> >
> > drivers/platform/arm ?
> Most certainly.
> 
> I'll submit that to drivers/platform/arm/pxa, and maintain that pxa tree. As for
> drivers/platform/arm, do you want also maintainers to step up, or will you take
> the review/merge burden ?

I have enough review/merge burden to do anything with ARM, sorry.
