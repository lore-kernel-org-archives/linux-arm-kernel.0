From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Apr 2017 11:21:57 -0700
Subject: [PATCH v2 1/3] mm: Silence vmap() allocation failures based on
 caller gfp_flags
In-Reply-To: <20170427182018.GC30672@dhcp22.suse.cz>
References: <20170427173900.2538-1-f.fainelli@gmail.com>
 <20170427173900.2538-2-f.fainelli@gmail.com>
 <20170427175653.GB30672@dhcp22.suse.cz>
 <416a788c-6160-1ce8-fccc-839f719b2a88@gmail.com>
 <20170427182018.GC30672@dhcp22.suse.cz>
Message-ID: <6f8480e5-5993-4b9c-2c28-0996ce4b0d81@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2017 11:20 AM, Michal Hocko wrote:
>>> would be shorter and you wouldn't need the goto and a label.
>>
>> Do you want me to resubmit with that change included?
> 
> Up to you. As I've said this is a nit at best.

I just sent a v3 based on feedback from Ard, thanks!
-- 
Florian
