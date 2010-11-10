From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 09 Nov 2010 21:51:01 -0500 (EST)
Subject: [PATCH 8/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <AANLkTimn2b6b8r8au48LWk4G4tNfbbR=TypAC1f3=e3e@mail.gmail.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-4-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-5-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-7-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-8-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTikk334vRT3HE9bQWc3u_jyLJckAY9AW=pVUQNbq@mail.gmail.com>
	<AANLkTimn2b6b8r8au48LWk4G4tNfbbR=TypAC1f3=e3e@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1011092149190.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Nov 2010, Haojian Zhuang wrote:

> On Tue, Nov 9, 2010 at 5:21 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > On Mon, Nov 8, 2010 at 8:37 PM, Haojian Zhuang
> > <haojian.zhuang@marvell.com> wrote:
> >> From: Zhou Zhu <zzhu3@marvell.com>
> >>
> >> iwmmx instructions are also used in PJ4. Add PJ4 support.
> >>
> >> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> Cc: Eric Miao <eric.y.miao@gmail.com>
> > This isn't good. Have to figure out a clean way for this.
> >
> 
> How about create new iwmmx.S and pj4-cp0.c? Since it can avoid macro.

Could you first explain why the CP15 reg number is different?  The 
commit message for the proposed patch does not give any explanation for 
the difference.


Nicolas
