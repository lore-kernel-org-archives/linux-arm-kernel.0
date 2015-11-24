From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 24 Nov 2015 17:47:17 +0100
Subject: [PATCH 00/13] mvneta Buffer Management and enhancements
In-Reply-To: <20151124.112253.2276973557484332376.davem@davemloft.net>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <20151124.112253.2276973557484332376.davem@davemloft.net>
Message-ID: <CAPv3WKc+NA58=sxXe-YhUZvE9ca0q=ZC5L9WZOvAevuWZhAnYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thanks for the remark. I will do the split and re-submit.

Best regards,
Marcin

2015-11-24 17:22 GMT+01:00 David Miller <davem@davemloft.net>:
>
> This patch series has a lot of problems.
>
> The worst one is that you are mixing bug fixes and new
> features/cleanups.
>
> You cannot do that.
>
> You _especially_ can't do that if you expect some of this stuff
> to be submitted to -stable too.
>
> Therefore you _must_ extract out the bug fixes, and submit those
> against 'net'.  And you must then wait for 'net' to be merged
> into 'net-next' before submitting the new feature patches.
>
> Furthermore, you should explicitly show what tree you are targetting
> your patches at, in your Subject lines.  In the form:
>
>         Subject: [PATCH $(TREE) N/M]
>
> Where $(TREE) is either 'net' or 'net-next'.
>
> THanks.
