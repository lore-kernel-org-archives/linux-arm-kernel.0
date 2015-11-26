From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Nov 2015 15:05:01 +0000
Subject: [PATCH v7 0/4] KASAN for arm64
In-Reply-To: <5656F991.8090108@virtuozzo.com>
References: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151013083432.GG6320@e104818-lin.cambridge.arm.com>
 <5649BAFD.6030005@arm.com> <5649F783.40109@gmail.com>
 <564B40A7.1000206@arm.com> <564B4BFC.1020905@virtuozzo.com>
 <20151126121007.GC32343@leverpostej>
 <5656F991.8090108@virtuozzo.com>
Message-ID: <20151126150501.GJ3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 03:22:41PM +0300, Andrey Ryabinin wrote:
> On 11/26/2015 03:10 PM, Mark Rutland wrote:
> > Can you pick up Andrey's patch below for v4.4, until we have a better
> > solution?
> 
> FYI, better solution is almost ready, I'm going to send it today.
> However, I don't know for sure whether it works or not :)

I merged the Kconfig fix for 4.4, it's not a significant loss since I
don't expect anyone to jump onto the 16K page configuration. We'll take
the proper fix for 4.5.

Thanks.

-- 
Catalin
