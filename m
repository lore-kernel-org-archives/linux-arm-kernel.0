From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 3 Sep 2014 20:19:33 +0800
Subject: [PATCH 0/7] mmc: sdhci/imx: a few clean up and fixes
In-Reply-To: <CAOMZO5D8GaMTCnGo4iO+eKYr6xXx3iyN-9pyNMUT-0f-dv1+FQ@mail.gmail.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
 <CAOMZO5D8GaMTCnGo4iO+eKYr6xXx3iyN-9pyNMUT-0f-dv1+FQ@mail.gmail.com>
Message-ID: <20140903121929.GA31326@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 09:34:28AM -0300, Fabio Estevam wrote:
> Hi Dong,
> 
> On Wed, Sep 3, 2014 at 9:04 AM, Dong Aisheng <b29396@freescale.com> wrote:
> > A few clean up and fixes.
> 
> Usually it is a good idea to separate cleanup from fixes. Do any of
> the fixes should go to 3.17-rc or stable?
> 

Thanks for reminder.
Most are tiny fixes and clean up.
If to be strictly, Patch 3 mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
could go to stable although the issue is very very hard to reproduce as stated
in errata.

Regards
Dong Aisheng

> Regards,
> 
> Fabio Estevam
