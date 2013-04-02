From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 2 Apr 2013 09:55:59 +0000
Subject: [PATCH v7 1/5] mmc: davinci: allow driver to work without DMA
 resource
In-Reply-To: <515A9941.9030708@ti.com>
References: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
 <1364476211-14322-2-git-send-email-prakash.pm@ti.com>
 <515A9941.9030708@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4BEAE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 14:09:29, Nori, Sekhar wrote:
> On 3/28/2013 6:40 PM, Manjunathappa, Prakash wrote:
> > Do not return probe failure with missing DMA resources,
> > allow driver to work in PIO mode.
> > Tested on da850-evm by mounting partition followed by
> > file creation and deletion.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> > Tested-by: Sekhar Nori <nsekhar@ti.com>
> 
> Chris accepted this patch on March 22nd. You should have dropped this
> from this series.
> 

Thanks Sekhar, I missed Chris's reply somehow.

Chris,
Please ignore this patch.

Regards,
Prakash
