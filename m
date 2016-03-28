From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 28 Mar 2016 09:42:09 -0400
Subject: [RFC PATCH 0/4] ACPI based PCI host driver with generic ECAM
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED2A787@lhreml503-mbs>
References: <CAKc_7PVK3VtaR-LDHNXPr5cSjbCcH--hsepFx=jVATNi=+a9Hw@mail.gmail.com>
 <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
 <CAKc_7PWfP0eQJ8dRN=CLu37=GKxin32Uf5rjiZGZgQCbiab2iA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED2A787@lhreml503-mbs>
Message-ID: <56F934B1.4080908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 3/23/2016 6:22 AM, Gabriele Paoloni wrote:
> I had a look at your patchset and also in your git repo at the other
> patches that you ported over from Tomasz; it seems that now we miss
> a quirk mechanism to enable controller that are not fully ECAM.
> 
> This was provided before by Tomasz in:
> https://lkml.org/lkml/2016/2/16/410
> 
> I think we should put something like that back in...
> 
> Thanks
> 
> Gab

I was requested to test your patchset. I'll need this mechanism before
I can start.

Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
