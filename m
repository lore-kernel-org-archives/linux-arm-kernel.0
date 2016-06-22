From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 22 Jun 2016 12:53:33 +0100
Subject: [[PATCH v2] 11/11] hwrng: exynos - fixup IO accesors
In-Reply-To: <20160622103705.GA30967@gondor.apana.org.au>
References: <20160622103705.GA30967@gondor.apana.org.au>
Message-ID: <82412f2a-bd8b-6ff4-9887-901d248398a4@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/16 11:37, Herbert Xu wrote:
> Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> The __raw IO functions are not endian safe, so use the readl_relaxed
>> and writel_relaxed versions of these.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> This patch has already been merged.
> 
> Cheers,

Apologies, only meant to repost the core patches.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
