From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sun, 03 Apr 2011 00:15:55 -0700
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <BANLkTim8GhUAZ7L-MiJiqi6xM=P_Q8kqfg@mail.gmail.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>	<BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>	<4D959058.7010606@codeaurora.org>
	<BANLkTim8GhUAZ7L-MiJiqi6xM=P_Q8kqfg@mail.gmail.com>
Message-ID: <4D981EAB.8070209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Please stop top posting)

On 4/1/2011 3:29 PM, Simon Glass wrote:
> Hi Stephen,
>
> Sorry for the confusion, but in fact I was talking about the patch to
> make ARM use the generic bug handling via an undef instruction instead
> of calling ______bug() or writing to memory address 0. Please see
> here:
>
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6808/1

Yes I've seen your patch (and even posted comments on it which have not
been responded to).

Correct me if I'm wrong, but that patch with CONFIG_BUG=n would lead to
the same error that Omar is seeing because the code only modifies the
bug infrastructure when CONFIG_BUG=y.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
