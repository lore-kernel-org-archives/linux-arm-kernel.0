From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 11 Aug 2011 09:54:53 +0800
Subject: [PATCH 0/3] mmp clockevent handling race fix
In-Reply-To: <CAN1soZy1LrO6mVWOs=Nt=s9reE=F+4DesmRQoqkCA7u1MJMWhA@mail.gmail.com>
References: <20110801224250.GF912@wantstofly.org>
	<CAN1soZy1LrO6mVWOs=Nt=s9reE=F+4DesmRQoqkCA7u1MJMWhA@mail.gmail.com>
Message-ID: <CAMPhdO-f-eaObRvtRYX0SGPxAUkz4nfmNPJXkgn7yspVjfoR-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 9:47 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Tue, Aug 2, 2011 at 6:42 AM, Lennert Buytenhek
> <buytenh@wantstofly.org> wrote:
>> This is a minimal fix for the mmp clockevent handling race reported
>> earlier:
>>
>> ? ? ? ?http://marc.info/?l=linux-arm-kernel&m=130745534131879&w=2
>> ? ? ? ?http://dev.laptop.org/ticket/10945
>>
>> This version needs some more testing, but looks OK so far.
>>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>

Thanks Haojian. Looks good to me too. Applied.
