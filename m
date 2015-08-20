From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Aug 2015 08:13:30 -0300
Subject: [PATCH] Revert "serial: imx: remove unbalanced clk_prepare"
In-Reply-To: <20150818233356.GA4494@localhost.localdomain>
References: <1439912592-14779-1-git-send-email-fabio.estevam@freescale.com>
 <20150818233356.GA4494@localhost.localdomain>
Message-ID: <CAOMZO5Czxr5TTtsrbRyD6N1a89AkeVSyam9Wo5tFxWkyE2iMfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 8:33 PM, Eduardo Valentin <edubezval@gmail.com> wrote:

> hmmm.. I really did not see this one. Looking at the code looks like we
> could be atomic in some of the uart console callbacks.
>
> For this one:
>
> Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
>
> Did you try the runtime pm patch on your end?

I have only tested linux-next.
