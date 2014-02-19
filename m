From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 09:04:58 -0500
Subject: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <20140219083025.GB10504@lee--X1>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <20140219083025.GB10504@lee--X1>
Message-ID: <20140219140458.GA10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Lee.

On Wed, Feb 19, 2014 at 08:30:25AM +0000, Lee Jones wrote:
> Can I do this as a subsequent patch though? The current patch fits
> neatly onto our internal stable kernel (currently v3.10). The added
> work will require back-porting Hans' patch-set, which has not yet
> reached Mainline.

Hmm.... I'll apply Hans' patchset pretty soon and we still have some
time in this devel cycle so I'd much prefer applying the final patch.

Thanks.

-- 
tejun
