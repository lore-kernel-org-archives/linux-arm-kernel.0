From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 9 Nov 2010 21:37:15 +0800
Subject: [PATCH 8/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <AANLkTikk334vRT3HE9bQWc3u_jyLJckAY9AW=pVUQNbq@mail.gmail.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-4-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-5-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-7-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-8-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTikk334vRT3HE9bQWc3u_jyLJckAY9AW=pVUQNbq@mail.gmail.com>
Message-ID: <AANLkTimn2b6b8r8au48LWk4G4tNfbbR=TypAC1f3=e3e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 9, 2010 at 5:21 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Mon, Nov 8, 2010 at 8:37 PM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
>> From: Zhou Zhu <zzhu3@marvell.com>
>>
>> iwmmx instructions are also used in PJ4. Add PJ4 support.
>>
>> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
> This isn't good. Have to figure out a clean way for this.
>

How about create new iwmmx.S and pj4-cp0.c? Since it can avoid macro.
