From: david.brown@linaro.org (David Brown)
Date: Wed, 14 Sep 2016 14:54:25 -0600
Subject: [kernel-hardening] [PATCH v3 0/7] arm64: Privileged Access Never
 using TTBR0_EL1 switching
In-Reply-To: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
References: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160914205425.GA15021@davidb.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 06:46:30PM +0100, Catalin Marinas wrote:

>This is the third version of the arm64 PAN emulation using TTBR0_EL1
>switching. The series has not yet included the alternative nop patches
>from Mark Rutland, nor the empty_zero_page from Ard B. This will be done
>in a subsequent version once 4.9-rc1 is out (which will include Mark's
>alternative nop patches).

I've tested these with a bunch of reboots in both qemu and HiKey and
have not seen the efi failure.

David
