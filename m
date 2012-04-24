From: jrnieder@gmail.com (Jonathan Nieder)
Date: Tue, 24 Apr 2012 01:10:27 -0500
Subject: [PATCH 1/2] ARM: ixp4xx: fix compilation, add gpiolib support
In-Reply-To: <20120412052518.GA3260@netboy.at.omicron.at>
References: <1328729069-21308-1-git-send-email-mkl@blackshift.org>
 <1328729069-21308-2-git-send-email-mkl@blackshift.org>
 <20120412052518.GA3260@netboy.at.omicron.at>
Message-ID: <20120424061027.GA23859@burratino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Cochran wrote:
> On Wed, Feb 08, 2012 at 08:24:28PM +0100, Marc Kleine-Budde wrote:

>> From: Imre Kaloz <kaloz@openwrt.org>
>>
>> The problem was introduced with commit:
>> "eb9ae7f gpio: fix build error in include/asm-generic/gpio.h"
>>
>> This patch adds gpiolib support for the IXP4xx platform, which fixes the
>> compilation of several ixp4xx platforms, e.g.:
>
> Sorry to nag, but is someone going to take this patch?

It looks like Russell's question[*] was never answered:

| Does anything on ixp4xx require fast access to on-chip GPIOs?  If not,
| it would be much better to get rid of this and just use the standard
| wrapping, which can be done by changing this entire file to be just a
| single line:

Hope that helps,
Jonathan

[*] http://thread.gmane.org/gmane.linux.kernel/1250585/focus=1250908
