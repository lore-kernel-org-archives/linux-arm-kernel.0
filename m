From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Mar 2011 13:24:27 -0000
Subject: [PATCH 2/2] ARM: perf: add required isbs() to ARMv7 backend
In-Reply-To: <AANLkTimcpgXnpXTbcK3WFaF3gt_FruBTGoqh7sbXJfWD@mail.gmail.com>
References: <1300289898-2720-1-git-send-email-will.deacon@arm.com>	<1300289898-2720-2-git-send-email-will.deacon@arm.com>	<AANLkTinQJ_1Ym8jVHjRP80XzC0PKzR+o9-Fdk56WzEF8@mail.gmail.com>	<9133336726495377032@unknownmsgid>
	<AANLkTimcpgXnpXTbcK3WFaF3gt_FruBTGoqh7sbXJfWD@mail.gmail.com>
Message-ID: <002601cbe894$780c0a90$68241fb0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> > I'd like to submit this to the patch system if you're happy with it.
> > Are you OK with the barrier coming before the write to the PMCR?
> 
> Yes I am OK
> 
> Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks for the ack. I've submitted these two patches as 6823/1 and
6824/1 respectively.

Cheers,

Will
