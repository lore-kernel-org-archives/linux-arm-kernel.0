From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 18 May 2013 13:32:39 +0200
Subject: [alsa-devel] [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
In-Reply-To: <20130518112505.GS1627@sirena.org.uk>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
 <20130517111523.GM1627@sirena.org.uk>
 <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
 <20130518112505.GS1627@sirena.org.uk>
Message-ID: <519766D7.9080802@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 01:25 PM, Mark Brown wrote:
> On Sat, May 18, 2013 at 07:03:24PM +0800, Barry Song wrote:
>> 2013/5/17 Mark Brown <broonie@kernel.org>:
> 
>>> Otherwise this looks OK for ASoC though I'd expect to see a change to
>>> registration of the OpenMoko BT device (perhaps I missed it though).
> 
>> sorry. i don't understand. i would think OpenMOKO can also use this driver?
> 
> If you change the names the driver uses to bind you need to also update
> the users so that they use the new name.
> 

Since there's the platform_device_id table now this should not be necessary.
