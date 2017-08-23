From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 23 Aug 2017 18:28:29 -0500
Subject: [PATCH 1/3] gliolib: request the gpio before querying its
 direction
In-Reply-To: <CACRpkdZv0NjXfwm_-TSoY=QFeP64V-ZoKvmLXk3qkV49fq1UtQ@mail.gmail.com>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
 <1501179565-26466-2-git-send-email-timur@codeaurora.org>
 <CACRpkdYPBd4ZvuXo__LRQezTQD3u=3r2WO+2dTzBanLL1zX72w@mail.gmail.com>
 <103341c8-6cc5-3d3f-eef7-28b9f31cdc71@codeaurora.org>
 <CACRpkdZv0NjXfwm_-TSoY=QFeP64V-ZoKvmLXk3qkV49fq1UtQ@mail.gmail.com>
Message-ID: <e1eae89c-f007-2e0b-cbb8-1aba71dae0e1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2017 03:32 AM, Linus Walleij wrote:
> It's right there on the "devel" branch from the GPIO git tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=devel

The devel branch is missing this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?id=83cf5faeba37fede8a6274d07f646d1cd1b25d35

which I need to avoid a merge conflict.  I'm going to submit a new 
version of my patches, but they won't apply on top of 'devel' unless you 
pull in that commit from linux-pinctrl.  Or you could copy that my 
gpiolib commit to linux-pinctrl.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
