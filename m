From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Apr 2014 11:28:17 +0100
Subject: [PATCH v2 00/10] arm64: UEFI support
In-Reply-To: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140429102817.GE17007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 05:09:04PM +0100, Leif Lindholm wrote:
> This set adds support for UEFI to the arm64 port - a stub loader, as
> well as runtime services support for efivars.
> 
> It depends on some core EFI patches currently in linux-next.

The patches look fine to me, they've been through several rounds of
review already. How do we propose these get merged as the series
contains both generic and arm64 patches? And there are dependencies
already in linux-next.

Are the EFI patches in -next pulled from some non-rebaseable branch?

-- 
Catalin
