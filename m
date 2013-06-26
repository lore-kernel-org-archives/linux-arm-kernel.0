From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Jun 2013 13:28:21 -0700
Subject: [RFC/PATCH 11/11] ARM: msm: Move MSM's DT based hardware to
 multi-platform support
In-Reply-To: <1372260541.6211.12.camel@iivanov-dev.int.mm-sol.com>
References: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
 <1371600281-6118-12-git-send-email-sboyd@codeaurora.org>
 <1372260541.6211.12.camel@iivanov-dev.int.mm-sol.com>
Message-ID: <20130626202821.GB11625@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26, Ivan T. Ivanov wrote:
> 
> You probably already know, but this patch causes compile error:
> 
> arch/arm/mach-msm/board-dt-8660.c:20:24: fatal error: mach/board.h: No such file or directory
> 
> I have fixed it locally like this:

Thanks. I think I'll just remove <mach/board.h> instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
