From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jul 2015 13:33:17 +0100
Subject: [PATCH v3 4/6] arm64: kernel: Add min_field_value and use '>='
 for feature detection
In-Reply-To: <1437481411-1595-5-git-send-email-james.morse@arm.com>
References: <1437481411-1595-1-git-send-email-james.morse@arm.com>
 <1437481411-1595-5-git-send-email-james.morse@arm.com>
Message-ID: <20150721123316.GC25887@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 01:23:29PM +0100, James Morse wrote:
> When a new cpu feature is available, the cpu feature bits will have some
> initial value, which is incremented when the feature is updated.
> This patch changes 'register_value' to be 'min_field_value', and checks
> the feature bits value (interpreted as a signed int) is greater than this
> minimum.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
