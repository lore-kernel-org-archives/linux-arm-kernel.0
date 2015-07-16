From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jul 2015 11:15:05 +0100
Subject: [PATCH 2/2] arm/smmu: Make use of of_parse_phandle_with_var_args
In-Reply-To: <1437035444-13867-3-git-send-email-joro@8bytes.org>
References: <1437035444-13867-1-git-send-email-joro@8bytes.org>
 <1437035444-13867-3-git-send-email-joro@8bytes.org>
Message-ID: <20150716101505.GB26390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Thu, Jul 16, 2015 at 09:30:44AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The function of_parse_phandle_with_args() can only handle 16
> args, but there are systems that require more (25 in my
> case). So use the newly introduced function
> of_parse_phandle_with_var_args() instead.

Looks good to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

Will
