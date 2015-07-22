From: james.morse@arm.com (James Morse)
Date: Wed, 22 Jul 2015 19:04:54 +0100
Subject: [PATCH v3 6/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <20150722170140.GR6650@arm.com>
References: <1437481411-1595-1-git-send-email-james.morse@arm.com>
 <1437481411-1595-7-git-send-email-james.morse@arm.com>
 <20150721123830.GD25887@localhost> <20150722170140.GR6650@arm.com>
Message-ID: <55AFDB46.3060302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 22/07/15 18:01, Will Deacon wrote:
> I've applied your series with the exception of this last one, as it
> conflicts with some other patches I have queued for 4.3. Please can you
> rebase this against the arm64 "devel" branch? (usually it would be
> for-next/core, but I'm holding off stabilising until -rc4 since allmodconfig
> build is broken atm).

The version of patch 5 "arm64: kernel: Add optional CONFIG_ parameter to
ALTERNATIVE()" in your tree has:

> [will: removed unused asm macro changes for now to avoid conflicts]

Those were used in arch/arm64/lib/clear_user.S and friends.
I shall remove the 'CONFIG_ARM64_PAN' from those four asm files - it can be
tidied up later.


Thanks,

James
