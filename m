From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 5 Dec 2011 08:51:46 +0000
Subject: [PATCH v2] ARM: restart: davinci: use new restart hook
In-Reply-To: <1322513934-23069-1-git-send-email-nsekhar@ti.com>
References: <1322513934-23069-1-git-send-email-nsekhar@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B603B24E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Nov 29, 2011 at 02:28:54, Nori, Sekhar wrote:
> Rather than using DaVinci specific davinci_soc_info based
> restart hook, use the restart hook available in the machine
> descriptor instead.
> 
> Tested on DM365 and AM18x EVMs.
> 
> v2:
> Changed to use restart hook in machine descriptor
> per Russell's comment.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

If you are OK with this patch, I will put it into
your patch system?

Thanks,
Sekhar
