From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Jun 2015 12:00:06 -0700
Subject: [PATCH 0/3] ARM: Allow SPARSEMEM on multiplatform build
In-Reply-To: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
References: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <5581C3B6.9090900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2015 06:58 PM, Gregory Fong wrote:
> This is based on the changeset submitted by Kevin Cernekee last September:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286835.html
>
> The changes I have made are:
> - update commit messages per review comments from Arnd and Russell
> - change to allow FLATMEM or SPARSEMEM on all multiplatform builds, not just
>   multi-v7
>
>

Things don't blow up on MSM8960 when switching between flatmem and
sparsemem so feel free to add:

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
