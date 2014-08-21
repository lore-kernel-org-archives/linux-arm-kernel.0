From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 Aug 2014 12:19:39 -0500
Subject: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
In-Reply-To: <00FC9A978A94B7418C33AFAE8A35ED49DF0662@DFLE09.ent.ti.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
 <1408636935-29515-1-git-send-email-nm@ti.com>
 <1408636935-29515-3-git-send-email-nm@ti.com>
 <00FC9A978A94B7418C33AFAE8A35ED49DF0662@DFLE09.ent.ti.com>
Message-ID: <53F62A2B.6010208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2014 11:59 AM, Murphy, Dan wrote:
[...]
Ooops.. missed answering one addition statement:

>> +	of_property_read_u32(np, "ti,palmas-long-press-seconds", &val);
> 
> Probably should check the return to make sure the value exists and that is is
> within an expected range.
It is an optional parameter and may not exist in dt. when it does
exist, the logic tries to do a best match (this is the for loop in the
logic just below).

-- 
Regards,
Nishanth Menon
