From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 4 Apr 2017 13:46:30 -0400
Subject: [PATCH v4 0/8] mfd: Add OF device table to I2C drivers that are
 missing it
In-Reply-To: <20170404174323.GA13234@atomide.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
 <20170404174323.GA13234@atomide.com>
Message-ID: <a5a9a7c2-1888-f6ba-5541-3cb3ee1d90ba@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

On 04/04/2017 01:43 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier@osg.samsung.com> [170404 08:33]:
>> Most patches can be applied independently, with the exception of patches
>> 2 to 4 that should be applied in the same tree to keep bisect-ability.
> 
> Probably best to merge this all via MFD or i2c:
>

I would prefer MFD since the changes in that subsystem are the ones that
could cause issues. The changes for I2C is just a update to an example.
 
> Acked-by: Tony Lindgren <tony@atomide.com>
>

Thanks!

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
