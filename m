From: tj@kernel.org (Tejun Heo)
Date: Tue, 29 Jul 2014 10:36:44 -0400
Subject: [PATCH v4 0/4]ata: Fixes related to APM X-Gene SATA host
 controller driver.
In-Reply-To: <CAOHikRCPY__5zTch--G3yTCdfdb=_NNoBB2tu_fANBm4JipBPw@mail.gmail.com>
References: <1406616892-30273-1-git-send-email-stripathi@apm.com>
 <20140729142648.GA4791@htj.dyndns.org>
 <CAOHikRCPY__5zTch--G3yTCdfdb=_NNoBB2tu_fANBm4JipBPw@mail.gmail.com>
Message-ID: <20140729143644.GC4791@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 08:05:45PM +0530, Suman Tripathi wrote:
> Hi,
> 
> Applied 1 and 3 to libata/for-3.17.  4 doesn't apply.  Also, please
> prefix the patches with "ahci_xgene: " from now on.
> 
> [suman] : You mean the "Remove NCQ patch" is not applied. Any reason for
> that ?

I meant that the patch doesn't apply to libata/for-3.17.  Please
always generate patches against the current devel branch.

Thanks.

-- 
tejun
