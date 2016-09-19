From: ayaka@soulik.info (Ayaka)
Date: Mon, 19 Sep 2016 17:41:50 +0800
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <20160919083342.GE10189@sirena.org.uk>
References: <1474207751-9804-1-git-send-email-ayaka@soulik.info>
 <1474207751-9804-2-git-send-email-ayaka@soulik.info>
 <20160919083342.GE10189@sirena.org.uk>
Message-ID: <1BBB8B7D-0C1B-48E0-A516-402515A04568@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



??? iPad ??

> Mark Brown <broonie@kernel.org> ? 2016?9?19? ??4:33 ???
> 
>> On Sun, Sep 18, 2016 at 10:09:11PM +0800, Randy Li wrote:
>> 
>> It is simple sound card time, we could assign different codec
>> to a interface without making a specific driver for it.
> 
>> config SND_SAMSUNG_AC97
>> -    tristate
>> +    tristate "Samsung AC97 controller support"
>>    select SND_SOC_AC97_BUS
> 
> Are you *sure* simple-card works for AC'97?
Not sure. I could hardly find a AC97 device in embedded market. If it didn't I could disable it. I have only tested simple sound card for i2s and SPDIF.
