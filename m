From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Apr 2012 09:58:02 -0600
Subject: Tegra board file deprecation schedule
In-Reply-To: <2573129.rORKuOVVxu@fb07-iapwap2>
References: <4F9B0E7C.1060408@wwwdotorg.org> <1388911.4olGsS8Z0g@ax5200p>
 <4F9D9396.9070009@wwwdotorg.org> <2573129.rORKuOVVxu@fb07-iapwap2>
Message-ID: <4F9EB68A.3080309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2012 02:58 AM, Marc Dietrich wrote:
> Am Sonntag, 29. April 2012, 13:16:38 schrieb Stephen Warren:
...
>> The correct approach here is to remove all the I2C logic from the NVEC
>> driver and add I2C slave support to the real I2C driver. Then, NVEC
>> becomes just a protocol driver for the slave transactions. Then, there
>> is no clock to deal with.
> 
> you are absolutely right, but there is no i2c slave controller driver in 
> mainline yet and I don't want to submit the one nvidia already wrote [1]. 
> Maybe you can ask around if someone is willing to do this.

Someone has been assigned to work on this, but other priorities are in
the way. Unfortunately, I don't have any realistic ETA I can give right now.
