From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 31 Mar 2010 02:15:42 +0100
Subject: [PATCH 0/4] HP iPAQ RX1950 patch series
In-Reply-To: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
Message-ID: <20100331011542.GN31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 08:20:05PM +0200, Vasily Khoruzhick wrote:
> Following patch series add support for iPAQ RX1950 PDA - another s3c2442-based
> machine.
> Almost all drivers for this machine are included in mainline kernel, and port
> only lacks battery, WiFi and sound support, they will be added later.
> 
> Port still uses machine-specific GPIO API, as generic GPIO lacks GPJ
> support and RX1950 actively uses GPJ port. However I do not see any benifits
> in using generic GPIO API in machine support file, as it will not be used
> with CPU different from s3c2442.

The samsung specific bits mirroring the gpio API will be removed, I will
add post a schedule for removal notice post the next kernel merge.
 
> Denis: I hope you'll add your Signed-off at least under first patch.
> 
> I doubt that I can get Signed-off from Victor Chukhantsev, as he doesn't
> work on port for a long time. 

The patches look ok. I'm not sure if someone else can vouch for Victor's
approval, or authenticty of patches. However if the main authours are
willing to authenticate the code, then I'll accept this unless someone
else objects.
 
> Regards,
> Vasily
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
