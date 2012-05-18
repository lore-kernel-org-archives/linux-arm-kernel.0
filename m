From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 May 2012 20:38:26 +0000
Subject: [PATCH 12/18] ARM: ux500: Disable platform setup of the ab8500
 when DT is enabled
In-Reply-To: <4FB64266.6040301@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <201205181112.17254.arnd@arndb.de> <4FB64266.6040301@linaro.org>
Message-ID: <201205182038.26512.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 May 2012, Lee Jones wrote:
> This is nice. Can I leave it for a now and submit this with the rest of 
> my clean-ups? I have a nice TODO list now that this would fit nicely 
> into. The way I see it, as long as this is submitted before we add a 
> mop500.dts then it's not going to cause anyone issues.

Yes, fine with me. I was thinking you'd fold it into the patch we
are commenting on, but if that's problematic, just add it to the
end of your queue.

	Arnd
