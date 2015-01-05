From: tj@kernel.org (Tejun Heo)
Date: Mon, 5 Jan 2015 09:05:29 -0500
Subject: [PATCH 2/2] ahci_xgene: Implement the workaround to support PMP
 enumeration and discovery for APM X-Gene SoC AHCI SATA Host Controller
 driver.
In-Reply-To: <CAOHikRBedNy=CrrHA+7UYQJpL3t1BhU0VFixz80bPeSE28iHGw@mail.gmail.com>
References: <1420453305-15986-1-git-send-email-stripathi@apm.com>
 <1420453305-15986-3-git-send-email-stripathi@apm.com>
 <20150105133005.GB15833@htj.dyndns.org>
 <20150105135950.GE15833@htj.dyndns.org>
 <CAOHikRBedNy=CrrHA+7UYQJpL3t1BhU0VFixz80bPeSE28iHGw@mail.gmail.com>
Message-ID: <20150105140529.GG15833@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 07:33:06PM +0530, Suman Tripathi wrote:
> Reverted due to conflicts with the endian fix patches.  Please rebase
> these two on top of them.
> 
> Will do that .. I should have wait for the endian patch getting
> accepted. Sorry for that.

Ooh, please don't be sorry.  It's completely fine.  These things
happen.

Thanks.

-- 
tejun
