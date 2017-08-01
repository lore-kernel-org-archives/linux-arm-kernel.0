From: agraf@suse.de (Alexander Graf)
Date: Tue, 1 Aug 2017 12:50:58 +0200
Subject: [PATCH v2 0/3] mailbox: arm: introduce smc triggered mailbox
In-Reply-To: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
References: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
Message-ID: <ffabbe33-5edd-4642-6038-5b48c87ad372@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 24.07.17 01:23, Andre Przywara wrote:
> This is a reworked version of my previous post. It addresses Jassi's
> comments on the driver and also tries to cover Rob's and Mark's comments
> on the binding documentation.
> I dropped the more example-like DT changes from v1, as they are actually
> not meant to be merged into the Linux tree, but instead are provided as
> part of some firmware actually implementing this functionality.
> 
> Please let me know what you think.

Could you please quickly explain what it would take to provide SCMI on 
top of this instead of SCPI?

https://lkml.org/lkml/2017/6/7/624

I can certainly see that SCPI is an easier target because it's already 
upstream and widely spread. But wouldn't it make sense to jump on the 
SCMI train while it's taking steam?


Thanks,

Alex
