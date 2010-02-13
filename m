From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 13 Feb 2010 22:54:48 +0000
Subject: [PATCH 05/10] ARM: ftrace: add ENDPROC annotations
In-Reply-To: <1266090518-31120-6-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-6-git-send-email-rabin@rab.in>
Message-ID: <4B772DB8.7060105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin Vincent wrote:
> When building as Thumb-2, the ".type foo, %function" annotation in
> ENDPROC seems to be required in order for the assembly routines to be
> recognized as Thumb-2 code.  If the ENDPROC annotations are not present,
> calls to these routines are generated as BLX instead of BL.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
