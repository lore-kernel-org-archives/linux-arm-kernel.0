From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 9 Nov 2015 21:26:47 -0600
Subject: [PATCH V2 2/3] scsi: fix compiler warning for sg
In-Reply-To: <564162AB.6080803@codeaurora.org>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <1447034266-28003-3-git-send-email-okaya@codeaurora.org>
 <CAHp75VdUBKr_XQ=2_5uSww71YVz+-Shmhg5hSe5KAoeshTtMYQ@mail.gmail.com>
 <564162AB.6080803@codeaurora.org>
Message-ID: <564163F7.2020109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
>
> I created this patch back in March with an older version of the compiler
> and older kernel (3.19). I'm no longer able to reproduce this with this
> compiler and linux-next.
>
> Thread model: posix
> gcc version 4.8.3 20140401 (prerelease) (crosstool-NG
> linaro-1.13.1-4.8-2014.04 - Linaro GCC 4.8-2014.04)
>
> I'll drop this patch.

Are you sure the compiler handles the old macro correctly?  Maybe it's 
just quiescing the error message, but it's still broken?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
