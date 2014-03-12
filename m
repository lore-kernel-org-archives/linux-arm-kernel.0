From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Mar 2014 16:09:31 +0000
Subject: [RFC PATCH v2 1/1] arm64: Add boot time configuration of
 Intermediate Physical Address size
In-Reply-To: <1394182165-10480-2-git-send-email-mohun106@gmail.com>
References: <1394182165-10480-1-git-send-email-mohun106@gmail.com>
 <1394182165-10480-2-git-send-email-mohun106@gmail.com>
Message-ID: <20140312160931.GE9691@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 08:49:25AM +0000, mohun106 at gmail.com wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> ARMv8 supports a range of physical address bit sizes. The PARange bits
> from ID_AA64MMFR0_EL1 register are read during boot-time and the
> intermediate physical address size bits are written in the translation
> control registers (TCR_EL1 and VTCR_EL2).
> 
> There is no change in the VA bits and levels of translation.

  Reviewed-by: Will Deacon <Will.deacon@arm.com>

Will
