From: tj@kernel.org (Tejun Heo)
Date: Tue, 18 Feb 2014 18:36:45 -0500
Subject: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20140218233645.GP31892@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 12:56:58PM +0000, Lee Jones wrote:
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Please consider basing it on top of Hans' refactored ahci_platform.

 http://www.spinics.net/lists/linux-ide/msg47628.html

Thanks.

-- 
tejun
