From: a0393675@ti.com (Keerthy)
Date: Mon, 22 Feb 2016 08:57:30 +0530
Subject: [PATCH] ARM: OMAP: DRA7: Make use of omap_revision information
 for soc_is* calls
In-Reply-To: <20160219181514.GK21202@atomide.com>
References: <1455706123-26497-1-git-send-email-j-keerthy@ti.com>
 <20160219181514.GK21202@atomide.com>
Message-ID: <56CA8022.6010206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 19 February 2016 11:45 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [160217 02:49]:
>> Currently of_machine_is_compatible is used to detect the soc which
>> employs string comparison operations. We already have all the required
>> information in the omap_revision. Hence make use of the same like
>> the previous OMAPs and avoid costly string comparisons.
>
> Looks good to me thanks. Applying into omap-for-v4.6/soc.

Thanks Tony.

>
> Tony
>
