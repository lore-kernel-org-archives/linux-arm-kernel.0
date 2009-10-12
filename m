From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Oct 2009 10:07:10 +0100
Subject: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
In-Reply-To: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
Message-ID: <20091012090710.GA29310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2009 at 02:20:23PM +0530, Nitin Gupta wrote:
> Same problem exists on mips too.

Nice catch.  This logic came from sparc64, so I think you'd want to talk
to davem about it as well.

In the mean time, submitting your fix to the patch system would be great,
thanks.
