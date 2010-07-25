From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 25 Jul 2010 13:40:13 +0300
Subject: [PATCH v2 10/20] omap: zoom: add fixed regulator device for wlan
In-Reply-To: <20100723091503.GA12300@rakim.wolfsonmicro.main>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-11-git-send-email-ohad@wizery.com>
	<20100721175930.GD10930@sirena.org.uk>
	<4C48287D.1000603@nokia.com>
	<AANLkTin2dyLNo1RMQgLG-4DtN-CsXqNNLAfITXDbMIvl@mail.gmail.com>
	<20100723091503.GA12300@rakim.wolfsonmicro.main>
Message-ID: <AANLkTi=qnAy+c7-xqcscyuy7Q4sgVsedZToEmZHo=y9y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 12:15 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jul 23, 2010 at 02:13:38AM +0300, Ohad Ben-Cohen wrote:
>> On Thu, Jul 22, 2010 at 2:16 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
>> > .dev_name ? ? ? = "mmci-omap-hs.2"
>
>> I already set the .dev member of the consumer in a similar manner to
>> how all other regulators are configured in this board - please check
>> out patch 13:
>
>> https://patchwork.kernel.org/patch/113418/
>
>> Does this look reasonable to you ?
>
> You should really be using dev_name in preference to dev these days
> unless there's a *very* good reason.

Changed, thank you.

I'll submit the updated patch now as a standalone patch as it has no
dependencies on the whole series, and it could only help to start
trimming that series down.

>
