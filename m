From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Nov 2015 17:35:58 +0000
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <563CE21A.6060803@linaro.org>
References: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
 <20151106123008.GK6087@arm.com> <20151106125002.GA8116@leverpostej>
 <20151106162109.GZ7637@e104818-lin.cambridge.arm.com>
 <20151106162538.GU6087@arm.com> <563CE21A.6060803@linaro.org>
Message-ID: <20151106173558.GC7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 09:23:38AM -0800, Shi, Yang wrote:
> On 11/6/2015 8:25 AM, Will Deacon wrote:
> >However, the patch would allow one to
> >disable FRAME_POINTERS (not sure it has any effect on the aarch64 gcc
> >though).
> 
> No, it doesn't. Actually, FRAME_POINTER could be disabled regardless of the
> patch.

In which case I suggest that we always select it just as a clearer
statement that the feature cannot be disabled (and you never know what
the compiler people decide to do in the future).

-- 
Catalin
