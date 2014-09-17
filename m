From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Sep 2014 18:16:10 +0100
Subject: [PATCH RESEND] arm64:mm: initialize max_mapnr using function
 set_max_mapnr
In-Reply-To: <1410890034-27228-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1410890034-27228-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <20140917171607.GA17701@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 06:53:54PM +0100, Ganapatrao Kulkarni wrote:
> Initializing max_mapnr using set_max_mapnr() helper function instead
> of direct reference. Also not adding PHYS_PFN_OFFSET to max_pfn,
> since it already contains it.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>

Applied, thanks.

-- 
Catalin
