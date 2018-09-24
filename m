From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2018 11:23:03 +0100
Subject: [RFC] arm64: lse: remove -fcall-used-x0 flag
In-Reply-To: <20180919192750.200491-1-trong@android.com>
References: <20180919192750.200491-1-trong@android.com>
Message-ID: <20180924102303.GC52978@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 12:27:50PM -0700, Tri Vo wrote:
> x0 is not callee-saved in the PCS. So there is no need to specify
> -fcall-used-x0.
> 
> Clang doesn't currently support -fcall-used flags. This patch will help
> building the kernel with clang.
> 
> Signed-off-by: Tri Vo <trong@android.com>

Queued for 4.20. Thanks.

-- 
Catalin
