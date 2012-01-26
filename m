From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 26 Jan 2012 08:09:29 +0100
Subject: [Fwd: Re: imx53]
In-Reply-To: <1327517782.21058.49.camel@hp-dhlii>
References: <1327517782.21058.49.camel@hp-dhlii>
Message-ID: <4F20FC29.2060500@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.01.2012 19:56, David Lynch Jr. wrote:
> I just pulled the most recent copy of linus's tree 3.3 something. 
> It appears that significantly more i.mx53 drivers are getting into that
> source than last time I looked. 
> 
> Now I am trying to build it for the i.MX53 QSB - the development
> platform I am using. 
> 
> Myriads of config options have changed since the 2.6.38.3 that I have
> somewhat working. Just borrowing the .config appears to be
> insufficient. 
> 
> After some mucking arround that included Kconfig changes I was able to
> get CONFIG_FB_IMX set and build a kernel with it, but it does not appear
> to be getting initialized. 
> 
> What do I need to do to get Linux to use this driver ?
> Has ARM 3.3 moved to device trees ?

Yes, I think so.

If you are new to this, one option would be to start with a recent 
Linaro i.MX53 Loco build (binary distribution). This could be a good 
option to get an idea how U-Boot, device tree and the kernel work 
together. In the next step you could replace the parts you are 
interested in by your own versions, then. E.g. the kernel.

Best regards

Dirk
