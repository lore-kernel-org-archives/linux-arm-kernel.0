From: terraluna977@gmail.com (Woody Suwalski)
Date: Fri, 16 Jul 2010 09:27:28 -0400
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded - 2.6.35-rc5
In-Reply-To: <20100716093744.GN11238@jirafa.cyrius.com>
References: <4C3C72C6.4000005@canonical.com>
Message-ID: <4C405E40.7040606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Michlmayr wrote:
> * Lee Jones<lee.jones@canonical.com>  [2010-07-16 10:08]:
>    
>>>> That sounds like a pretty serious problem.  But presumably it isn't -
>>>> otherwise it would have been fixed earlier!
>>>>          
>> Well it is a problem on OMAP based boards.
>>      
> It's not just OMAP.  Debian received a similar bug report a few days
> too and it was on Marvell Orion hardware.  I simply disabled the
> parport_pc module on ARM.
>
>    
That works for you because Debian no longer supports Netwinders 8-(

Woody
