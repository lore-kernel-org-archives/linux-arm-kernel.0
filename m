From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Nov 2014 16:31:07 +0000
Subject: [PATCH v5 4/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <1416310887-14649-5-git-send-email-punit.agrawal@arm.com>
References: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
 <1416310887-14649-5-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141120163107.GD5447@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 11:41:25AM +0000, Punit Agrawal wrote:
> The SWP instruction was deprecated in the ARMv6 architecture. The
> ARMv7 multiprocessing extensions mandate that SWP/SWPB instructions
> are treated as undefined from reset, with the ability to enable them
> through the System Control Register SW bit. With ARMv8, the option to
> enable these instructions through System Control Register was dropped
> as well.
> 
> To support legacy applications using these instructions, port the
> emulation of the SWP and SWPB instructions from the arm port to arm64.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
