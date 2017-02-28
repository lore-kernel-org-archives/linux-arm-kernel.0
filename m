From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 27 Feb 2017 22:11:57 -0600
Subject: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
In-Reply-To: <C6D2336E-DD53-43DB-B323-2BD00A17E298@mykolab.com>
References: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
 <C6D2336E-DD53-43DB-B323-2BD00A17E298@mykolab.com>
Message-ID: <9a203593-3dcb-c730-52fd-6a2b79febf13@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christopher Covington wrote:
> You might want to make this <= 1 and also change firmware to 0 so that new
> firmware with old kernels, new kernels with old firmware, and new kernels
> with new firmware all get the workaround applied.

I thought about that, but there is apparently no firmware that sets the value to 0.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
