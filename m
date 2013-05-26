From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Sun, 26 May 2013 21:05:09 +0200
Subject: [linux-sunxi] [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c
 driver
In-Reply-To: <1781939.MrE9Xthq6W@flatron>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
 <51A1E9AA.4000008@schinagl.nl> <1781939.MrE9Xthq6W@flatron>
Message-ID: <51A25CE5.4040901@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/13 16:44, Tomasz Figa wrote:
> Hi Oliver,
>
> I can recommend you a great tool to browse through Linux sources:
> http://lxr.free-electrons.com/source/lib/devres.c?a=arm#L107
>
> It really helps looking up in code things that you aren't sure.
>
> Best regards,
> Tomasz
>
Yeah, I'm allready a heavy user of LXR ;) But sometimes there's just 
information overload and things become hard to follow. Especially when 
there's several ways to do something.

I would have hoped that a 'ldd4' would be available which has OF support 
written in. ldd3 lacks all that.
