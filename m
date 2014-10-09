From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Thu, 9 Oct 2014 15:25:16 +0800
Subject: [PATCH resend] arm:extend the reserved memory for initrd to be
 page aligned
In-Reply-To: <CAMuHMdUDxemAOsE1E1Ba3zjhtMSp-k=n4_YxRJ2k_C_kZdBr=Q@mail.gmail.com>
References: <35FD53F367049845BC99AC72306C23D103D6DB49161F@CNBJMBX05.corpusers.net>
 <CAMuHMdUDxemAOsE1E1Ba3zjhtMSp-k=n4_YxRJ2k_C_kZdBr=Q@mail.gmail.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB491642@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Who guarantees there's no valuable data in [start, initrd_start) and
> [initrd_end, end) being corrupted?
> 
mm..
I am not sure if the memblock_reserve will reserve
Memory from page aligned address?
If not, do we need also make memblock_reserve the initrd memory
>From page aligned start(round down) to page aligned end address(round up) ? 

Thanks
