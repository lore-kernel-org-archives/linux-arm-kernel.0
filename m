From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Apr 2012 18:56:58 +0100
Subject: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
In-Reply-To: <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <20120426191159.GA9415@sirena.org.uk>
 <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
Message-ID: <20120427175657.GP18260@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:09:10AM +0530, J, KEERTHY wrote:

> Devfreq and cpufreq are related to dynamic frequency/voltage switching between
> pre defined Operating Performance Points or the OPPs. Every OPP being
> a voltage/frequency pair. Smartreflex is a different
> power management technique.

But presumably these things should integrate somehow - for example,
should devfreq and cpufreq be providing inputs into what AVS is doing,
and if so how?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120427/0bce95d8/attachment.sig>
