From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 16 Dec 2015 10:55:29 +0000
Subject: [PATCH v3 4/4] drivers: psci: replace psci firmware calls
In-Reply-To: <20151201194421.GA29068@ermac>
References: <1448449461-5043-1-git-send-email-jens.wiklander@linaro.org>
 <1448449461-5043-5-git-send-email-jens.wiklander@linaro.org>
 <20151201184741.GE29045@leverpostej> <20151201194421.GA29068@ermac>
Message-ID: <20151216105529.GC19814@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ed Daniel]

On Tue, Dec 01, 2015 at 08:44:22PM +0100, Jens Wiklander wrote:

[...]

> > What's the plan for merging this? I assume this'll go via arm-soc?
> 
> I talked to Arnd about this and he suggested to go via Russel.

Heads-up, this patch will conflict with:

https://patchwork.kernel.org/patch/7418351/

that goes via linux-pm tree, please let me and Daniel know how
you want us to sort this out.

Thanks,
Lorenzo
