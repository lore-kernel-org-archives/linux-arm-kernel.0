From: martinwguy@gmail.com (Martin Guy)
Date: Thu, 27 Jan 2011 06:28:32 +0100
Subject: [PATCH] ep93xx: add framebuffer support to edb93xx boards
In-Reply-To: <0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
References: <Acuuu5ny+zlvst9wTH+OPBMrDizm+g==>
	<0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
Message-ID: <AANLkTi=SDZ7EAw5Q=XAD3WtutwCHSgfiw-qQ5z4TcYCS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2011 23:38, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
> The ep9307, ep9312, and ep9315 variants of the ep93xx processor include the
> raster engine needed for framebuffer support.
>
> This allows the EDB93xx boards with those processors to use the framebuffer
> driver.
>
> Tested on an EDB9307A with the following kernel parameters:
> ? ? ? ?video=640x480-16 at 60
> ? ? ? ?video=1024x768-16 at 60

Hi. Sorry, I've been out of action for personal reasons.

I don't have an edb to test this, but suggest you compare with the
simone.c board file, which has similar code to enable the fb.
Compared to the mainline code in 2.6.36, I use just one patch, which
defines the working video modes. I attach it for reference.

    M
-------------- next part --------------
A non-text attachment was scrubbed...
Name: simone-set-video-modes.patch
Type: text/x-patch
Size: 2038 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110127/7e1eba14/attachment.bin>
