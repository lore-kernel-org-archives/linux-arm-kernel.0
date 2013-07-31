From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Jul 2013 13:09:55 -0600
Subject: New dapm panic on beaver with next-20130730
In-Reply-To: <20130731103610.GH9858@sirena.org.uk>
References: <CAOesGMig6jry1GJLoTnOqxom1KjtBTUtZz-_-SiZLpGTc3VkqA@mail.gmail.com>
 <51F8A933.4080708@metafoo.de>
 <CAOesGMjqyF7zPoGsW6oBRFey7Bc_umnoGob7oQ=_c3n7oevuaQ@mail.gmail.com>
 <51F8B045.8030303@metafoo.de> <20130731103610.GH9858@sirena.org.uk>
Message-ID: <51F96103.6000603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 04:36 AM, Mark Brown wrote:
> On Wed, Jul 31, 2013 at 08:35:49AM +0200, Lars-Peter Clausen
> wrote:
> 
>> 0x6b6b6b6b is poisoned freed memory. According to the source
>> neither the INR Mux nor the INL Mux widget should have any sinks.
>> Can you add a couple more printks:
> 
> Dan Carpenter sent a patch which is probably the issue - I'm trying
> to figure out how to boot my Beaver board so hopefully I can test,
> it'll be in -next tomorrow anyway.

I assume that is "[patch] ASoC: dapm: using freed pointer in
dapm_kcontrol_add_widget()". That doesn't fix the issue. Do you need
me to debug any further?
