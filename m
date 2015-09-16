From: damien.thebault@vitec.com (=?utf-8?B?RGFtaWVuIFRow6liYXVsdA==?=)
Date: Wed, 16 Sep 2015 07:39:17 +0000
Subject: NFS/TCP/IPv6 acting strangely in 4.2
In-Reply-To: <87zj0mbzsj.fsf@free-electrons.com>
References: <20150911113839.GO21084@n2100.arm.linux.org.uk>
 <1442386435.3756.282.camel@vitec.com> <87zj0mbzsj.fsf@free-electrons.com>
Message-ID: <1442389156.3756.285.camel@vitec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-16 at 09:15 +0200, Gregory CLEMENT wrote:
> > Since it worked fine on 4.0 I bisected until I found commit
> > a84e32894191cfcbffa54180d78d7d4654d56c20 "net: mvneta: fix
> > refilling
> > for Rx DMA buffers".
> > 
> > If I revert this commit, everything seems to get back to normal.
> > Could you try it ? The two issues look very similar.
> Actually there was a bug with this commit, but a fix had been
> submitted
> and accepted yesterday, you can find him here:
> https://patchwork.ozlabs.org/patch/518111/.

Hello, this indeed fixes the issue for me, thanks.
-- 
Damien Th?bault
R&D Engineer
VITEC

T. +33 1 46 73 06 06
F. +33 9 59 85 99 92
E. damien.thebault at vitec.com
http://www.vitec.com
