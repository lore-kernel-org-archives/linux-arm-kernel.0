From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 20 Oct 2017 09:44:55 +0200
Subject: [PATCH] pinctrl: rockchip: Add iomux-route switching support for
 rk3288
In-Reply-To: <2040825.vRYCsv903Y@diego>
References: <20171013225337.5196-1-phh@phh.me> <13020229.tRmotBUImn@phil>
 <52d1a9ee-a6c6-5c7f-330f-9b672be9c2c6@xs4all.nl> <2040825.vRYCsv903Y@diego>
Message-ID: <68b8765d-3d55-3fdd-e23e-776e978c38bd@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/17 09:38, Heiko St?bner wrote:
> Hi Hans,
> 
> Am Freitag, 20. Oktober 2017, 09:28:58 CEST schrieb Hans Verkuil:
>> On 14/10/17 17:39, Heiko Stuebner wrote:
>>> So far only the hdmi cec supports using one of two different pins
>>> as source, so add the route switching for it.
>>>
>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>
>> Just tested this on my firefly reload and it works great!
>>
>> Tested-by: Hans Verkuil <hans.verkuil@cisco.com>
> 
> oh cool. I really only wrote this based on the soc manual,
> so it actually surprises me, that it works on the first try :-)

One note though: I've only tested it on my Firefly Reload. I don't have a
regular Firefly, so I can't be certain it works there. Just covering my ass
here :-)

> 
>> I'll post some dts patches later today to fully bring up the first HDMI
>> output on the Firefly Reload.
>>
>> Will you process this patch further to get it mainlined?
> 
> Yep, I'll do that.

Thanks!

Regards,

	Hans
