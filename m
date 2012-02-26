From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 14:02:52 -0800
Subject: [PATCH] ARM: tegra: Avoid compiling cpuidle code when not
 configured
In-Reply-To: <1330014112-26203-1-git-send-email-pdeschrijver@nvidia.com>
References: <1330014112-26203-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120226220252.GE11189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 06:21:52PM +0200, Peter De Schrijver wrote:
> No need to compile cpuidle.c and sleep.S if cpuidle isn't configured in the
> kernel.

Thanks, applied to for-3.4/soc.

-Olof
