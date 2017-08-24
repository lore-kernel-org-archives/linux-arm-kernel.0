From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 24 Aug 2017 17:00:37 -0500
Subject: [PATCH 1/3] gliolib: request the gpio before querying its
 direction
In-Reply-To: <CACRpkdZ-=uyFntmwL3Z8dg32ovRwRuz0XRXr833TEjokvg+5=A@mail.gmail.com>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
 <1501179565-26466-2-git-send-email-timur@codeaurora.org>
 <CACRpkdYPBd4ZvuXo__LRQezTQD3u=3r2WO+2dTzBanLL1zX72w@mail.gmail.com>
 <103341c8-6cc5-3d3f-eef7-28b9f31cdc71@codeaurora.org>
 <CACRpkdZv0NjXfwm_-TSoY=QFeP64V-ZoKvmLXk3qkV49fq1UtQ@mail.gmail.com>
 <e1eae89c-f007-2e0b-cbb8-1aba71dae0e1@codeaurora.org>
 <CACRpkdZ-=uyFntmwL3Z8dg32ovRwRuz0XRXr833TEjokvg+5=A@mail.gmail.com>
Message-ID: <038c4c8a-ec3f-2c61-420f-2bd5b54b5c3c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2017 04:28 PM, Linus Walleij wrote:
> I don't see how you can have a merge conflict between this
> patch that only affects gpiolib.c and something in the pin
> control tree?

Actually, the merge conflict is because this is missing in the gpio tree:

pinctrl: msm: add support to configure ipq40xx GPIO_PULL bits

> The merge window is imminent, so if it is not extremely urgent
> I would opt to wait until after.

As long as it gets into 4.14-final, I don't care which specific RC it 
appears in.  Thanks.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
