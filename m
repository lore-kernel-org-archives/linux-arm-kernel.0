From: bp@suse.de (Borislav Petkov)
Date: Wed, 10 Aug 2016 12:45:13 +0200
Subject: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic>
 <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
Message-ID: <20160810104513.GB16664@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 06:40:53PM +0800, Fu Wei wrote:
> But the reason for a  separate hest_ia32_init() is:
> For now(ACPI 6.1), we have three IA-32 Architecture-specific error
> source structures, maybe we will parse them later.
> So I made this hest_ia32_init() for all these structures. maybe we can do :

So I'd make it as simple as possible now and cross that bridge only when
we get there, i.e., only when you are adding support for those and not
earlier.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
--
