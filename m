From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Mar 2015 12:46:20 +0000
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <CAKohponaQYYgYFAbpY3KZjt4+QhjBsqQtEpG5QpdMH0p__YUEQ@mail.gmail.com>
References: <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
 <20150311105307.GW28806@sirena.org.uk>
 <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
 <1426074142.30734.7.camel@pengutronix.de>
 <CAKohponaQYYgYFAbpY3KZjt4+QhjBsqQtEpG5QpdMH0p__YUEQ@mail.gmail.com>
Message-ID: <20150311124620.GC28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 05:16:42PM +0530, Viresh Kumar wrote:

> I think until the time we revive the voltage-domain stuff we need to support
> mediatek's driver. And probably a virtual regulator is the best approach
> unless someone else comes up with another idea.

Why not just write a custom cpufreq driver if it's too hard to abstract?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/1bc74ad1/attachment.sig>
