From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 14 May 2018 16:49:26 -0500
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <19c4b830-9f50-d5ea-3e31-587477210ee1@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <8c2648ec-1379-fb2a-35d2-b3fa8fc9f063@arm.com>
 <20180509154055.GB25559@xps15>
 <19c4b830-9f50-d5ea-3e31-587477210ee1@arm.com>
Message-ID: <20180514164926.61c11b9b96256599491269d9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2018 17:02:34 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> probe (and thus call coresight_register()) first. Oh well, I guess 
> poking amba_bustype really does remain the only reasonable answer.

Thanks all, I've added Robin's Reviewed-by, and submitted this patch to
RMK's patch tracking system, here:

http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8773/1

Cheers,

Kim
