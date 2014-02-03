From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 03 Feb 2014 16:44:53 +0000
Subject: [PATCH v5 00/16] uprobes: Add uprobes support for ARM
In-Reply-To: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
References: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
Message-ID: <1391445893.3509.36.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-23 at 15:05 -0500, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> This patch series adds basic uprobes support to ARM. It is based on patches
> developed earlier by Rabin Vincent. That approach of adding hooks into
> the kprobes instruction parsing code was not well received. This approach
> separates the ARM instruction parsing code in kprobes out into a separate set
> of functions which can be used by both kprobes and uprobes. Both kprobes and
> uprobes then provide their own semantic action tables to process the results of
> the parsing.

Assuming my comment about 'const' use in patch 5 is addressed, then for
patches 2 to 14 you can add:

Acked-by: Jon Medhurst <tixy@linaro.org>

Thanks Dave for persevering.

-- 
Tixy
