From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 09:04:42 +0200
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120920160314.b3ea668fc0766224c24bf276@canb.auug.org.au>
References: <20120920160314.b3ea668fc0766224c24bf276@canb.auug.org.au>
Message-ID: <CACRpkdaLr-v2CBjZsqLGx_tmthJYLscnEQhhDQrqTAQ0TVW87g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 8:03 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-integrator/integrator_cp.c between commit 73efd53012af
> ("ARM: 7519/1: integrator: convert platform devices to Device Tree") from
> the arm tree and commit b7a3f8db07c1 ("ARM: integrator: use __iomem
> pointers for MMIO") from the arm-soc tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks correct!
Thanks.
Linus Walleij
