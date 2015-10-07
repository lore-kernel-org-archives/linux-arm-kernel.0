From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Oct 2015 11:04:11 +0100
Subject: [PATCH v6 0/6] KASAN for arm64
In-Reply-To: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <20151007100411.GG3069@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 12:38:06PM +0300, Andrey Ryabinin wrote:
> As usual patches available in git
> 	git://github.com/aryabinin/linux.git kasan/arm64v6
> 
> Changes since v5:
>  - Rebase on top of 4.3-rc1
>  - Fixed EFI boot.
>  - Updated Doc/features/KASAN.

I tried to merge these patches (apart from the x86 one which is already
merged) but it still doesn't boot on Juno as an EFI application.

-- 
Catalin
