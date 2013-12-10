From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 10 Dec 2013 11:58:39 +0000
Subject: [PATCH] arm64: Add hwcaps for crypto and CRC32 extensions.
In-Reply-To: <1383081038-3241-1-git-send-email-steve.capper@linaro.org>
References: <1383081038-3241-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20131210115837.GA23226@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 09:10:38PM +0000, Steve Capper wrote:
> Advertise the optional cryptographic and CRC32 instructions to
> user space where present. Several hwcap bits [2-6] are allocated.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Hi,
I was wondering if this patch looked ok to people?

Cheers,
-- 
Steve
