From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 10 Jul 2013 11:32:42 +0200
Subject: [PATCH v4 2/7] Documentation: DT: add sam9x5ek-wm8731 machine
 driver
In-Reply-To: <20130709150114.GB27646@sirena.org.uk>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-3-git-send-email-richard.genoud@gmail.com>
 <20130709150114.GB27646@sirena.org.uk>
Message-ID: <CACQ1gAjxWYVrOM8wvq7emArO7s_bion-ZgnB9tx3DN5htoV2qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/9 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 09, 2013 at 04:25:28PM +0200, Richard Genoud wrote:
>> This add the sound DT binding for sam9x5ek-wm8731 machine driver
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>  .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |   30 ++++++++++++++++++++
>
> Put new binding documents in the same patch that reads them, this makes
> review easier.
ok, I'll squash it with patch 1

>> +  - atmel,audio-routing: A list of the connections between audio components.
>
> This needs to be more specific and list the available board specific
> nodes for routing.  For the CODEC you can just refer to the CODEC
> binding documentation.
Ok, I'll do that.

>> +  - atmel,format: DAI format. Must be "i2s"
>
> So why not just omit this then?
Will be removed.

>
>> +  - atmel,bitclock-master:  DAI clock master
>> +  - atmel,frame-master: DAI frame master
>
> The driver isn't handling these and there's no information on how to set
> them.
They will also go away.


Thanks !
