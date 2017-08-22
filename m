From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Aug 2017 18:46:57 +0100
Subject: [PATCH v2 0/2] cleanup {COMPAT_,}SET_PERSONALITY
In-Reply-To: <20170820102048.7537-1-ynorov@caviumnetworks.com>
References: <20170820102048.7537-1-ynorov@caviumnetworks.com>
Message-ID: <20170822174657.rqg7lyudo3nakucz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 20, 2017 at 01:20:46PM +0300, Yury Norov wrote:
> This patchset is the result of discussion:
> https://lkml.org/lkml/2017/7/31/454
> 
> First patch introduces MMCF flags for mm_context_t ->flags to separate it from
> TIF ones. And second patch moves personality-related setup code from
> SET_PERSONALITY() to the helper.
> 
> Yury Norov (2):
>   arm64: introduce separated bits for mm_context_t flags
>   arm64: cleanup {COMPAT_,}SET_PERSONALITY() macro

Patches queued for 4.14. Thanks.

-- 
Catalin
