From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 24 Aug 2012 14:18:56 +0200
Subject: [PATCH 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <1345799361-23735-4-git-send-email-gregory.clement@free-electrons.com>
References: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
 <1345799361-23735-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CABJ1b_Sk2jb=xmnvcY5AHHLUs5j6vGWJWqL_q0Rc5akAfdJhRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/24/12, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> +++ b/arch/arm/mm/cache-l2x0.c
> ...
> @@ -597,6 +838,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)

Hi all,

IMHO l2x0_of_init shouldn't rely on anything else but the compatible device node
found. Is there any other way to set aux_val and aux_mask from DT or match data?

Sebastian
