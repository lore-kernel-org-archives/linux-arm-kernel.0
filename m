From: hs@denx.de (Heiko Schocher)
Date: Wed, 01 Feb 2012 07:40:24 +0100
Subject: [PATCH v3] ARM: davinci: map default_queue to edma channels
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317970CE@DBDE01.ent.ti.com>
References: <1326956721-25158-1-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6317970CE@DBDE01.ent.ti.com>
Message-ID: <4F28DE58.3040902@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nori,

Nori, Sekhar wrote:
> Hi Heiko,
> 
> On Thu, Jan 19, 2012 at 12:35:21, Heiko Schocher wrote:
>> Default queue is expected to be a low-priority queue.
>> This way, long transfers on the default queue started
>> by the codec engine will not cause audio defects.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
>> Signed-off-by: juha.kuikka at gmail.com
>> Reported-by: juha.kuikka at gmail.com
> 
> Sign-off should include real name, so I changed these
> two lines to:
> 
>     Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
>     Reported-by: Juha Kuikka <juha.kuikka@gmail.com>

Thanks!

> before applying. Let me know if anyone has objections.

I saw no objections, so can this patch go in now?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
