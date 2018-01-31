From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Wed, 31 Jan 2018 18:16:03 +0100
Subject: [PULL 00/28] KVM/ARM Changes for v4.16
In-Reply-To: <20180131093507.22219-1-christoffer.dall@linaro.org>
References: <20180131093507.22219-1-christoffer.dall@linaro.org>
Message-ID: <20180131171602.GA26944@flask>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-31 10:34+0100, Christoffer Dall:
> Hi Paolo and Radim,
> 
> Apologies for getting this pull request to you rather late; there were a
> number of issues that I wanted to make sure we could fix properly before
> including some of the changes in this pull request.
> 
> The changes for this version include icache invalidation optimizations
> (improving VM startup time), support for forwarded level-triggered
> interrupts (improved performance for timers and passthrough platform
> devices), a small fix for power-management notifiers, and some cosmetic
> changes.

Pulled, thanks.
