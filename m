From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Mon, 01 Dec 2014 13:19:28 +0000
Subject: [PATCH] drm: i2c: tda998x: Retry fetching the EDID if it fails
 first time.
In-Reply-To: <20141129114102.02366857@armhf>
References: <546B84C6.3090809@arm.com>	<20141128091905.3e491c39@armhf>	<54783A2F.5010405@arm.com>
 <20141129114102.02366857@armhf>
Message-ID: <547C6AE0.80808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/14 10:41, Jean-Francois Moine wrote:
> On Fri, 28 Nov 2014 09:02:39 +0000
> Andrew Jackson <Andrew.Jackson@arm.com> wrote:
> 
>>> It seems that your patch is deprecated by Laurent Pinchart's
>>> 	[PATCH] drm: tda998x: Use drm_do_get_edid()
>>> http://lists.freedesktop.org/archives/dri-devel/2014-November/072906.html
>>>   
>>
>> Thank you for the heads-up, I'd not seen that.  I'll consider how my patch might be modified to suit the new infrastructure.
> 
> You don't need any patch: drm_do_get_edid() already loops on reading
> the EDID.
> 

Thank you again: that saves me work!

   Andrew
