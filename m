From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Nov 2012 14:56:12 +0100
Subject: [PATCH v2 2/5] ARM: gic: remove direct use of gic_raise_softirq
In-Reply-To: <50AA39A4.1060006@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-3-git-send-email-robherring2@gmail.com>
 <20121102124433.GA28213@bnru03> <20121119115021.GA19788@bnru10>
 <20121119130718.025b7a2c@skate> <50AA39A4.1060006@gmail.com>
Message-ID: <CACRpkdZ=4Q8KakSSKdC8Nd2FntKUnH2pa87fprf5U_fFDrgX+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 2:52 PM, Rob Herring <robherring2@gmail.com> wrote:

>> I have merged Linus Walleij patches into my irqchip branch with more
>> changes around the irqchip infrastructure. That said, it will not be
>> part of the 3.8 release cycle, so we will definitely take care of
>> re-spinning against the latest ux500 changes.
>
> I still hope to get some of the clean-up in for 3.8 if not the move
> itself. So I can include your patch. Is it in an arm-soc branch already?

Please include this patch, I haven't seen it in ARM SoC, and
I sure think Srinidhi's intention was to take it together with
these patches.

Yours,
Linus Walleij
