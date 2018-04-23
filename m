From: dev@pascalroeleven.nl (Pascal Roeleven)
Date: Mon, 23 Apr 2018 13:01:03 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Fix incorrect clocks
 for displays
In-Reply-To: <20180423071421.byupsz4gxpmhfe44@flea>
References: <20180420102112.2843-1-dev@pascalroeleven.nl>
 <20180423071421.byupsz4gxpmhfe44@flea>
Message-ID: <887c9144972ab75a4520141a17e1607b@pascalroeleven.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-23 09:14, Maxime Ripard wrote:
> On Fri, Apr 20, 2018 at 12:21:12PM +0200, Pascal Roeleven wrote:
>> Some displays on SUN4i devices wouldn't properly stay on unless
>> 'clk_ignore_unused' is used.
>> 
>> Change the duplicate clocks to the probably intended ones.
>> 
>> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> 
> What was the difference with the first patch you sent?
> 
> Anyway, I've applied it, thanks
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

I'm sorry there isn't any.
It's the first patch I have ever send so had some git-send-email issues 
and
didn't know the correct procedure to resend a patch.
