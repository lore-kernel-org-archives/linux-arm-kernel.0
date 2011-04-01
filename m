From: sjg@chromium.org (Simon Glass)
Date: Fri, 1 Apr 2011 15:29:08 -0700
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <4D959058.7010606@codeaurora.org>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>
	<4D959058.7010606@codeaurora.org>
Message-ID: <BANLkTim8GhUAZ7L-MiJiqi6xM=P_Q8kqfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Sorry for the confusion, but in fact I was talking about the patch to
make ARM use the generic bug handling via an undef instruction instead
of calling ______bug() or writing to memory address 0. Please see
here:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6808/1

Regards,
Simon

On Fri, Apr 1, 2011 at 1:44 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 3/31/2011 6:47 PM, Simon Glass wrote:
>> You might try the generic bug patch and see if it also fixes this
>> problem - Simon
>
> It probably won't because presumably Omar has CONFIG_BUG=n otherwise
> Omar would have sent a patch against __bug() in arch/arm/kernel/traps.c
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
