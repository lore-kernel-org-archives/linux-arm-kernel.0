From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 7 Nov 2017 11:16:05 +0900
Subject: [PATCH v4] arm64: support __int128 on gcc 5+
In-Reply-To: <20171107021316.GA23638@arm.com>
References: <20171103141858.13149-1-Jason@zx2c4.com>
 <20171106093151.8312-1-Jason@zx2c4.com>
 <20171106155917.glgjgipppzsdpp6h@armageddon.cambridge.arm.com>
 <20171107021316.GA23638@arm.com>
Message-ID: <CAHmME9q56O8ow+moUDtzuLakgJyy-KgwRQQnub8zjRrd=Bj1-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Nov 7, 2017 at 11:13 AM, Will Deacon <will.deacon@arm.com> wrote:
> So I pushed a fixup patch on top of for-next/core, but I suggest we
> temporarily revert the- DCONFIG_ARCH_SUPPORTS_INT128 option if any other
> issues crop up.

The fixup looks good to me.

If there are additional problems, I'm happy to keep providing patches
until it's sorted. I just did an allyesconfig and didn't have any
problems, though, so I think we're all set now.

Jason
