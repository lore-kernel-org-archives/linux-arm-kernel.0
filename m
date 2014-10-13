From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Mon, 13 Oct 2014 05:26:11 -0700
Subject: Regarding tx-nocache-copy in the Sheevaplug
In-Reply-To: <20141013105246.GD1972@vicerveza.homeunix.net>
References: <20141013105246.GD1972@vicerveza.homeunix.net>
Message-ID: <1413203171.9362.81.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-13 at 12:52 +0200, Llu?s Batlle i Rossell wrote:
> Hello,
> 
> on the 7th of January 2014 ths patch was applied:
> https://lkml.org/lkml/2014/1/7/307
> 
> [PATCH v2] net: Do not enable tx-nocache-copy by default
>         
> In the Sheevaplug (ARM Feroceon 88FR131 from Marvell) this made packets to be
> sent corrupted. I think this machine has something special about the cache.
> 
> Enabling back this tx-nocache-copy (as it used to be before the patch) the
> transfers work fine again. I think that most people, encountering this problem,
> completely disable the tx offload instead of enabling back this setting.
> 
> Is this an ARM kernel problem regarding this platform?

Which NIC and driver is this exactly ?
