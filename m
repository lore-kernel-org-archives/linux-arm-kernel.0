From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Mar 2013 09:19:29 -0600
Subject: linux-next: manual merge of the bcm2835 tree with the arm-soc tree
In-Reply-To: <20130318150415.7a9db62e8cfe03623a411ae9@canb.auug.org.au>
References: <20130318150415.7a9db62e8cfe03623a411ae9@canb.auug.org.au>
Message-ID: <51473081.2040607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2013 10:04 PM, Stephen Rothwell wrote:
> Hi Stephen,
> 
> Today's linux-next merge of the bcm2835 tree got a conflict in 
> arch/arm/Kconfig between commit 15bc1fe67f66 ("ARM: cns3xxx:
> enable multiplatform support") from the arm-soc tree and commit
> f1ac922dec7e ("ARM: bcm2835: convert to multi-platform") from the
> bcm2835 tree.

Thanks. The resolution for the two bcm2835/arm-soc conflicts looks
fine. These conflicts should go away once I send bcm2835 pull requests
to arm-soc for inclusion in 3.10.
