From: geoff@infradead.org (Geoff Levand)
Date: Wed, 06 Jul 2016 10:46:55 -0700
Subject: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
In-Reply-To: <20160706075226.27609-9-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-9-takahiro.akashi@linaro.org>
Message-ID: <1467827215.8880.44.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add documentation for linux,usable-memory and linux,elfcorehdr chosen
> nodes used by arm64 kexec to decribe the kdump reserved area, and the
> elfcorehdr's location within it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [akashi: wrap the commit description to avoid a checkpatch warning]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Look OK.

Reviewed-by: Geoff Levand <geoff@infradead.org>
