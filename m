From: Zubair.Kakakhel@imgtec.com (Zubair Lutfullah Kakakhel)
Date: Thu, 17 Jul 2014 10:02:34 +0100
Subject: [PATCH 3/4] x86: use generic dma-contiguous.h
In-Reply-To: <xa1ta989b7ha.fsf@mina86.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
 <xa1ta989b7ha.fsf@mina86.com>
Message-ID: <53C7912A.4080404@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/07/14 17:20, Michal Nazarewicz wrote:
> On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> wrote:
>> dma-contiguous.h is now in asm-generic. Use that to avoid code
>> repetition in x86.
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> 
> But to be honest, I would fold the three into a single commit.

Thank-you for the acks. I understand as its a trivial change.

But architectures like it separate. They will obviously go
together via one tree.

ZubairLK
