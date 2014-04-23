From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Apr 2014 10:05:36 +0100
Subject: [PATCH] arm64: Make default dma_ops to be noncoherent
In-Reply-To: <1398230986-2823-2-git-send-email-ritesh.harjani@gmail.com>
References: <20140422152152.GG9820@arm.com>
 <1398230986-2823-1-git-send-email-ritesh.harjani@gmail.com>
 <1398230986-2823-2-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <20140423090536.GB5281@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 06:29:46AM +0100, Ritesh Harjani wrote:
> Currently arm64 dma_ops is by default made coherent
> which makes it opposite in default policy
> from arm.
> 
> Make default dma_ops to be noncoherent (same
> as arm), as currently there aren't any
> dma-capable drivers which assumes coherent ops
> 
> Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
