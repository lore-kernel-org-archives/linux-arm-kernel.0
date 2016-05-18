From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 18 May 2016 10:43:20 +1000
Subject: QRTR merge conflict resolution
In-Reply-To: <20160517.141154.1511755950068252376.davem@davemloft.net>
References: <20160510183934.GJ1256@tuxbot> <2606282.lG9qK7uBW0@wuerfel>
 <20160513221909.GC1256@tuxbot>
 <20160517.141154.1511755950068252376.davem@davemloft.net>
Message-ID: <20160518104320.23ae8557@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tue, 17 May 2016 14:11:54 -0400 (EDT) David Miller <davem@davemloft.net> wrote:
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Date: Fri, 13 May 2016 15:19:09 -0700
> 
> > I have prepared the merge of net-next and the conflicting tag from the
> > Qualcomm SOC, please include this in your pull towards Linus to avoid
> > the merge conflict.  
> 
> Pulled, thanks.

Except in the merge resolution, the 2 new functions added to
include/linux/soc/qcom/smd.h (qcom_smd_get_drvdata and
qcom_smd_set_drvdata) were not marked "static inline" :-(

-- 
Cheers,
Stephen Rothwell
