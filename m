From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 18 Aug 2017 09:41:54 +0800
Subject: [PATCH v3 2/9] ASoC: rockchip: Remove obsolete dmic-delay
In-Reply-To: <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-3-jeffy.chen@rock-chips.com>
 <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
Message-ID: <599645E2.4020402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

thanks for your reply

On 08/18/2017 01:11 AM, Mark Brown wrote:
> On Thu, Aug 17, 2017 at 12:44:10PM +0800, Jeffy Chen wrote:
>
>> This property is no longer used.
>
>> -Optional properties:
>> -- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
>> -  If this option is specified, which means it's required dmic need
>> -  delay for DMIC to ready so that rt5514 can avoid recording before
>> -  DMIC send valid data
>
> Why would nobody ever want to use this in future?
>

hmmm, check again, rt5514 fixed this issue in there driver instead in:
a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.

so we don't need this...
