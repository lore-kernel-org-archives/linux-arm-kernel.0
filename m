From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Jimenez)
Date: Tue, 9 Mar 2010 14:37:09 -0300
Subject: [PATCH] ARM: mach-sa1100: Put nanoEngine support back in the
	kernel.
In-Reply-To: <20100309175229.c231f088.kristoffer.ericson@gmail.com>
References: <1268148843-13135-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100309175229.c231f088.kristoffer.ericson@gmail.com>
Message-ID: <cecb6d8f1003090937t4ec3fe1cw293be3735caa2648@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kristoffer,

On Tue, Mar 9, 2010 at 13:52, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
>
> Without testing it on the actual hardware it applies and looks good, compilation also goes smoothly without any issues.
> It looks quite alright to me. What are you planning to do with the fixup function?

Sorry, this function was the first things I wrote, but the kernel 2.6
infrastructure made it totally unnecessary and it should have been
removed. I will do it and send another patch.

> Im just missing the licensing text in the nano...c file for future reference,

Ok, I will add it too.

> after that feel free to add:
> Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
>
> Best wishes
> Kristoffer

Regards,
Marcelo.
