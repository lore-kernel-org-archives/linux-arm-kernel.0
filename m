From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 2 Mar 2015 09:37:37 -0800
Subject: [PATCH 00/10] ARM: s3c64xx multiplatform, help needed
In-Reply-To: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
Message-ID: <20150302173737.GB17094@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 01:35:53PM +0100, Arnd Bergmann wrote:
> Hi everyone,
> 
> I've had these patches in a private git tree for a while, and have
> finally gotten around to clean them up some more for submission.
> Hopefully we can get all of it merged into 4.1.
> 
> I've done this to the best of my knowledge, but some parts are
> a bit tricky, so I expect that there are bugs. The trickiest
> part is the touchscreen driver. I've sent it out for review
> last year already, but I have not found anybody who could test
> it, and it's basically a blind rewrite of an existing driver,
> so it's unlikely that I got it all right.

I think Vasily had access to hardware with s3c2410_ts at some point...

> 
> The other parts may actually work, but it is possible that
> I made a mistake with the ASoC driver, the sparseirq support
> or something else.
> 
> Does anyone still have access to the hardware? I'm particularly
> interested in seeing this patch set get tested on smartq
> and on smdk6410, which have the majority of the hardware.

Thanks.

-- 
Dmitry
