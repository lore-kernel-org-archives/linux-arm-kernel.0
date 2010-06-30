From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Jun 2010 11:48:32 +0100
Subject: Pending patches for -rc
In-Reply-To: <20100630101223.GA24284@n2100.arm.linux.org.uk>
References: <20100630101223.GA24284@n2100.arm.linux.org.uk>
Message-ID: <1277894912.13942.29.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-30 at 11:12 +0100, Russell King - ARM Linux wrote:
> ARM: 6189/1: Add support for the MOVW/MOVT relocations in Thumb-2

Thumb-2 modules of certain size may get these relocations and they'll
fail to load.

> ARM: 6190/1: Remove dummy loads from the original relocation address
> ARM: 6191/1: Do not compile the Thumb-2 module relocations on an ARM
> kernel

These two aren't critical, I agree.

BTW, should these patches be re-submitted or you would carry them to the
next merging window?

-- 
Catalin
