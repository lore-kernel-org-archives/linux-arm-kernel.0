From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 14 Sep 2009 13:03:33 +0200 (CEST)
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0909141259290.4359@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Thu, 10 Sep 2009, Eric Miao wrote:

> Here's the preview of request-pull result, please let me know if there
> is anything missed, thanks.
> 
> URL: git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git

[snip]

> Guennadi Liakhovetski (3):
>       [ARM] pxa/pcm990: convert pcm990 to soc-camera as platform-device
>       [ARM] pxa/mioa701: convert mioa701 to the new platform-device soc-camera interface
>       [ARM] pxa/em-x270: convert em-x270 to soc-camera as platform-device

Could you please try to push your tree to Linus as early in the merge 
cycle as possible? The v4l tree depends on the above patches, and sh 
depends on v4l. Is your tree going to Linus via Russell or directly?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
