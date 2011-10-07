From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Fri, 07 Oct 2011 15:39:35 +0400
Subject: [PATCH] ARM: tegra: fix compilation error due to mach/hardware.h
	removal
In-Reply-To: <1317954199-25284-1-git-send-email-olof@lixom.net>
References: <1317954199-25284-1-git-send-email-olof@lixom.net>
Message-ID: <4E8EE4F7.9040503@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-10-2011 6:23, Olof Johansson wrote:

> From: Marc Dietrich <marvin24@gmx.de>

> This fixes a compilation error in cpu-tegra.c which was introduced
> in commit dc8d966bccde0b8b6c9e8c6e663c747030c17435 which removed

    Please also specify that commit's summary in parens.

> the now obsolete mach/hardware.h from the mach-tegra subtree.

> Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>

WBR, Sergei
