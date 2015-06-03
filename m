From: rsahu@apm.com (Rameshwar Sahu)
Date: Wed, 3 Jun 2015 12:37:57 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix "incorrect type in assignement"
 warnings
In-Reply-To: <20150602133538.GZ3140@localhost>
References: <1433235813-3225-1-git-send-email-rsahu@apm.com>
 <20150602133538.GZ3140@localhost>
Message-ID: <CAFd313xEKKqqNDLPpmPdT_Hsd0LstDtsBvE-z0mhaaVv_KhDJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 7:05 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>
> On Tue, Jun 02, 2015 at 02:33:33PM +0530, Rameshwar Prasad Sahu wrote:
> > This patch fixes sparse warnings like incorrect type in assignment
> > (different base types), cast to restricted __le64.
> >
> I am appliying this but ideally you should have split thsi into seprate
> patches for each fix



Thanks, I will take care this for next time.
Ram
>
>
> --
> ~Vinod
>
