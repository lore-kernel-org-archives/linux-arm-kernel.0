From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Thu, 17 May 2018 15:54:17 +0300
Subject: [PATCH 1/3] crypto: ccree: drop signature register check
In-Reply-To: <1526387370-17142-2-git-send-email-gilad@benyossef.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-2-git-send-email-gilad@benyossef.com>
Message-ID: <CAOtvUMcN2kYFQEiMc7ignecPTdt9yOnfs2=TDjRnMAJ9WNRbuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Herbert,

On Tue, May 15, 2018 at 3:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> We were using the content of the signature register as a sanity
> check for the hardware functioning but it turns out not all
> implementers use the same values so the check is giving false
> negative on certain SoCs and so we drop it.
>

Please drop this patch. I have found a better fix and will send a v2 soon.

Thanks,
Gilad


-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
