From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 26 Jun 2017 14:39:42 -0700
Subject: [PATCH 2/2] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
In-Reply-To: <20170626213534.jur6rggwbzhk6r4t@piout.net>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
 <20170615195904.12653-3-f.fainelli@gmail.com>
 <20170624185942.vq656pjxbqnqdhll@piout.net>
 <35c43786-ee58-130c-2ecd-5577197bd5aa@gmail.com>
 <20170626213534.jur6rggwbzhk6r4t@piout.net>
Message-ID: <9d8f0475-5a52-c7dc-2f39-1b5cbad608e9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2017 02:35 PM, Alexandre Belloni wrote:
> On 26/06/2017 at 10:15:46 -0700, Florian Fainelli wrote:
>>> This is not needed since d68778b80dd7
>>
>> Great, I will take that out.
>>
>> Do you care whether some dev_dbg() prints are left in the driver or
>> should I remove those in v2?
>>
> 
> It could have stayed but it seems you removed it from v2.
> 
> I'll applay that but it is ok if you change your mind.

No, I think they don't really belong in the driver anymore, thanks!
-- 
Florian
