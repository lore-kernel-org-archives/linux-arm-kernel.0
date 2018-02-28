From: p.pisati@gmail.com (Paolo Pisati)
Date: Wed, 28 Feb 2018 17:13:45 +0100
Subject: Internal error: Oops - BUG() / kvm boot race - arm64 kpti
 patchset related
In-Reply-To: <CAKv+Gu-AkN=PE7+q2R_QADoAcsd=Z+xgPXutTwSqb_oBUr-gpg@mail.gmail.com>
References: <20180228154523.GA29931@akinoame>
 <CAKv+Gu-AkN=PE7+q2R_QADoAcsd=Z+xgPXutTwSqb_oBUr-gpg@mail.gmail.com>
Message-ID: <20180228161345.GB31013@akinoame>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 03:51:09PM +0000, Ard Biesheuvel wrote:
> 
> First of al, v4.4.20 ?!? How on earth could that have anything to do with KPTI?

Sorry, i meant 4.14.20...

> 
> In any case, you could try whether this patch helps at all, or at
> least makes your bisect less inconclusive.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=fixes/core&id=753e8abc36b2c966caea075db0c845563c8a19bf

-- 
bye,
p.
