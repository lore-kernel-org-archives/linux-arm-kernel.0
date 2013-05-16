From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 16 May 2013 13:54:08 +0200
Subject: [PATCH 2/6] ARM: davinci: dm365 evm: remove init_enable from
 ths7303 pdata
In-Reply-To: <CA+V-a8txWU=ohuJfmtKk5fQ_rh_qsp8wA72vUXWEDBZU1TJR-g@mail.gmail.com>
References: <1368619042-28252-1-git-send-email-prabhakar.csengg@gmail.com>
 <CA+V-a8uU6QkYcMg1b5BPHbA0gUGypZeXZNScE-WLa-GqK4_fQA@mail.gmail.com>
 <CA+V-a8txWU=ohuJfmtKk5fQ_rh_qsp8wA72vUXWEDBZU1TJR-g@mail.gmail.com>
Message-ID: <8665087.XDPi8z3vzr@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

On Thursday 16 May 2013 17:18:00 Prabhakar Lad wrote:
> On Wed, May 15, 2013 at 5:41 PM, Prabhakar Lad wrote:
> > On Wed, May 15, 2013 at 5:35 PM, Laurent Pinchart wrote:
> >> On Wednesday 15 May 2013 17:27:18 Lad Prabhakar wrote:
> >>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> >>> 
> >>> remove init_enable from ths7303 pdata as it is no longer exists.
> >> 
> >> You should move this before 1/6, otherwise you will break bisection.
> 
> How about I just reshuffles while issuing a pull rather than resending
> the whole series ?

As long as you don't forget to do so, sure :-)

-- 
Regards,

Laurent Pinchart
