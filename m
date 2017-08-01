From: panand@redhat.com (Pratyush Anand)
Date: Tue, 1 Aug 2017 09:10:05 +0530
Subject: [PATCH RFC] arm64: introduce mm_context_t flags
In-Reply-To: <20170731144825.31322-1-ynorov@caviumnetworks.com>
References: <20170731144825.31322-1-ynorov@caviumnetworks.com>
Message-ID: <5e0f1ae7-3a69-0d1c-3f33-ddb44ed8b6c5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 31 July 2017 08:18 PM, Yury Norov wrote:
>   - If we start using TIF flags here, we cannot easily add new mm_context
>     specific bits because they may mess with TIF ones.

This one seems convincing argument. ATM do you have any mm_context flag which 
would you like to incorporate?

> 
> I think that this is not what was intended when you added new field in
> mm_context_t.
> 
> In this patch the MMCF_AARCH32 flag is introduced, where MMCF prefix stands for
> mm_context_t flags. And the new flag is used for uprobes code instead of TIF_32BIT.

-- 
Regards
Pratyush
