From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 12 Sep 2018 21:38:34 +0200
Subject: [stable PATCH 2/2] arm64: Handle mismatched cache type
In-Reply-To: <1536052210-11625-2-git-send-email-suzuki.poulose@arm.com>
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
 <1536052210-11625-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180912193834.GG21563@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 10:10:10AM +0100, Suzuki K Poulose wrote:
> commit 314d53d297980676011e6fd83dac60db4a01dc70 upstream
> 
> Track mismatches in the cache type register (CTR_EL0), other
> than the D/I min line sizes and trap user accesses if there are any.
> 
> Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
> Cc: <stable@vger.kernel.org> # v4.9

Same 4.9 question here as well.

thanks,

greg k-h
