From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 6 Feb 2012 16:34:53 -0500
Subject: [PATCH 3/3] ARM: remove empty disable_fiq and arch_ret_to_user
 macros
In-Reply-To: <1328562200-8810-4-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-4-git-send-email-robherring2@gmail.com>
Message-ID: <CACb=_tSUsvdudkBzTy_RRH3bDwhf4nQ_Jk2mb17TPoUuu+e4aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 6 February 2012 16:03, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that most platforms don't need disable_fiq and arch_ret_to_user
> macros, we can remove the empty macros or empty entry-macro.S files.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
[...]
> ?arch/arm/mach-picoxcell/include/mach/entry-macro.S | ? 16 -----------

I'm unable to test at the moment, but this series looks good to me.
For the picoxcell part:

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
