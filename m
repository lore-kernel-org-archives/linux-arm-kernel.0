From: wufan@codeaurora.org (wufan)
Date: Thu, 30 Aug 2018 13:45:19 -0600
Subject: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <CABo9ajCui0y9HMBzgKWeNtrbu4de+mLh=d9Qdkyo4zhU9az6hw@mail.gmail.com>
References: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
 <CABo9ajCui0y9HMBzgKWeNtrbu4de+mLh=d9Qdkyo4zhU9az6hw@mail.gmail.com>
Message-ID: <001901d44099$fc8d7550$f5a85ff0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler, 

> > +static int get_dimm_smbios_index(u16 handle) {
> > +       struct mem_ctl_info *mci;
> > +       int i;
> > +
> > +       mci = ghes_pvt->mci;
> > +
> 
> Minor nit: you could define and set mci in the same line to save some space
> here.
> 
> Otherwise this patch looks good to me.

Good catch Tyler! I'll fix it.

Thanks,
Fan

> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
