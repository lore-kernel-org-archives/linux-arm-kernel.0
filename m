From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 16 Apr 2013 10:06:26 +0200
Subject: [PATCH v3 00/15] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <516C9A87.4090307@tabi.org>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
 <516A9D5B.2070707@metafoo.de> <516C9A87.4090307@tabi.org>
Message-ID: <516D0682.5010309@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 02:25 AM, Timur Tabi wrote:
> Lars-Peter Clausen wrote:
>>> >@Lars:
>>> >There are 4 new patches at the beginning of the series that fix some
>>> problems
>>> >of your cleanups. I think they were in the changes you posted. If not,
>>> could you
>>> >please add them to your branch?
>> Hi,
>>
>> I had already fixed them localy. I'm in the process of polishing the last
>> bits
>> and pieces of my generic dmaengine PCM driver series right now and will
>> submit
>> it later today.
> 
> So which repository should I apply these patches to?  I want to make sure
> they don't break PowerPC.
> 

You can use
https://github.com/lclausen-adi/linux-2.6/tree/asoc-dmaengine-cleanups, but
make sure to skip the first 4 patches from this series.

- Lars
