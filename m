From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 18 Nov 2015 15:48:28 +0000
Subject: [PATCH v7 0/4] KASAN for arm64
In-Reply-To: <564C8C47.1080904@gmail.com>
References: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151013083432.GG6320@e104818-lin.cambridge.arm.com>
 <5649BAFD.6030005@arm.com> <5649F783.40109@gmail.com>
 <20151116165100.GE6556@e104818-lin.cambridge.arm.com>
 <564C8C47.1080904@gmail.com>
Message-ID: <564C9DCC.50205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/15 14:33, Andrey Ryabinin wrote:

> Is there any way to run 16K pages on emulated environment?
> I've tried:
>   - ARM V8 Foundation Platformr0p0 (platform build 9.4.59)

Have you tried with the following option ?

-C cluster<N>.has_16k_granule=1

Thanks
Suzuki
