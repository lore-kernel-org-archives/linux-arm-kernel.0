From: joel@jms.id.au (Joel Stanley)
Date: Thu, 20 Sep 2018 16:52:18 +0930
Subject: [PATCH v3] ARM: dts: aspeed: Adding Facebook TiogaPass BMC
In-Reply-To: <20180918234110.1908926-1-vijaykhemka@fb.com>
References: <20180918234110.1908926-1-vijaykhemka@fb.com>
Message-ID: <CACPK8Xd_ZKrQa3b98Bpb=wy_P3=FDUjPDfBSHx5Wx_NHk6Y5og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vijay,

On Wed, 19 Sep 2018 at 09:11, Vijay Khemka <vijaykhemka@fb.com> wrote:
> Initial introduction of Facebook TiogaPass family equipped with
> Aspeed 2500 BMC SoC. TiogaPass is a x86 server development kit
> with a ASPEED ast2500 BMC manufactured by Facebook.
> Specifically, This adds the tiogapass platform device tree file
> including the flash layout used by the tiogapass BMC machines.
>
> This also adds an entry of tiogapass device tree file in Makefile
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

It looks like you've addressed the concerns from previous reviews. If
any comments come up please address them in follow up patches.

I made some minor whitespace fixes and applied this to the aspeed
v4.20 device tree branch.

Cheers,

Joel
