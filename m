From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 31 Jul 2013 17:25:17 -0400
Subject: AArch64 arch_spin_unlock not signaling global event?
In-Reply-To: <CANz0V+6-yk9jWZ1y9zidKFJAhDof9qQR1uAHzsvhwswApMbxUA@mail.gmail.com>
References: <CANz0V+6-yk9jWZ1y9zidKFJAhDof9qQR1uAHzsvhwswApMbxUA@mail.gmail.com>
Message-ID: <51F980BD.2050904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei,

On 07/31/2013 04:19 PM, Andrei E. Warkentin wrote:
> Hiya,
> 
> I've noticed the AArch64 arch_spin_unlock is implemented with the
> 'stlr' instruction.
> 
> Shouldn't that be followed by a 'sev'?

Check the git log and go through silver to make sure you're looking at the
latest documentation. I believe the link from infocenter is stale.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
