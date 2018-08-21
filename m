From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Aug 2018 01:04:37 +0100
Subject: [PATCH] arm64/crypto: remove non-standard notation
In-Reply-To: <20180820224032.53194-1-ndesaulniers@google.com>
References: <20180820224032.53194-1-ndesaulniers@google.com>
Message-ID: <20180821000436.GB1758@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 03:40:32PM -0700, Nick Desaulniers wrote:
> It seems that:
> ldr q8, =0x30000000200000001
> 
> is a GNU as convience notation for:
> ldr q8, .Lconstant
> .Lconstant
> .word 0x00000001
> .word 0x00000002
> .word 0x00000003
> .word 0x00000000

Does still this work correctly for a big-endian build?

Will
