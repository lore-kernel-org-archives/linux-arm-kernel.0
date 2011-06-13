From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 13 Jun 2011 17:55:16 +0400
Subject: [Patch v2 03/11] ARM: hwcaps: use shifts instead of hardcoded
	constants
In-Reply-To: <1307536233-30089-4-git-send-email-will.deacon@arm.com>
References: <1307536233-30089-1-git-send-email-will.deacon@arm.com>
	<1307536233-30089-4-git-send-email-will.deacon@arm.com>
Message-ID: <4DF616C4.4040709@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-06-2011 16:30, Will Deacon wrote:

> The HWCAP numbers are defined as constants, each one being a power of 2.
> This has become slightly unwieldy now that we have reached 32k.

> This patch changes the HWCAP defines to use (1<<  n) instead of coding
> the constant directly. The values remain unchanged.

    Perhaps it's better to use BIT(n) macro instead?

> Signed-off-by: Will Deacon <will.deacon@arm.com>

WBR, Sergei
