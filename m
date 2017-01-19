From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Thu, 19 Jan 2017 20:51:53 +0200
Subject: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
In-Reply-To: <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
 <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
 <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
Message-ID: <ecdc073b-d83f-ba7d-89bf-da8899414217@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 03:47 PM, Peter Ujfalusi wrote:
> On 01/15/2017 09:08 PM, Jarkko Nikula wrote:
>> However v4.9.4 works and with it I can see there is an issue with these
>> aic3x controls:
>>
>> amixer: Unable to find simple control 'Left DAC_L1 Mixer Line',0
>>
>>
>>
>> amixer: Unable to find simple control 'Right DAC_R1 Mixer Line',0
> 
> These are certainly not the regression between 4.6 and 4.9, more like
> more like regression since 2.6:
> 'Line Switch' -> 'LineL Switch':
> 54f01916297bafc18bd7df4e2300a0544a84fce3
> 
> 'LineL Switch' -> 'DACL1 Switch':
> c3b79e05b4d9ab2e7c3ba281261ea87ab5b71a92
> 
You are right. Those mixer scripts were for Maemo 2.6.28 kernel and
dated 2009... grr, looks like I've overwritten my N900 mixer scripts at
some point.

Fortunately the issue seems to be fixed in v4.10-rc4.

-- 
Jarkko
