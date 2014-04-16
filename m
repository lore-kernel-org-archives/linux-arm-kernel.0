From: ipaton0@gmail.com (Iain Paton)
Date: Wed, 16 Apr 2014 19:33:06 +0100
Subject: [RFC PATCH] imx6: imx6duallite/solo i2c4 clock
In-Reply-To: <20140416074712.GK2523@dragon>
References: <534CF8A3.3010404@gmail.com> <20140416074712.GK2523@dragon>
Message-ID: <534ECCE2.1060006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/14 08:47, Shawn Guo wrote:
> On Tue, Apr 15, 2014 at 10:15:15AM +0100, Iain Paton wrote:
>> I'm working on a board using the imx6solo that implements i2c4 and while 
>> building the devicetree it became clear that the devicetree fragment for 
>> i2c4 in imx6dl.dtsi it's missing the necessary clock.
>>
>> Investigating further turned up that the ecspi5 clock in CCM_CCGR1 on the 
>> quad/dual is replaced with the i2c4 clock on duallite/solo.
>>
>> Would the following patch be sufficient to allow correct use of this clock?
> 
> Yes, Iain.  It looks correct to me.  Care to send a formal patch for it?

Sure, it's on it's way.
