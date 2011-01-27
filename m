From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 27 Jan 2011 10:43:57 -0600
Subject: [PATCH] ep93xx: add framebuffer support to edb93xx boards
In-Reply-To: <AANLkTi=SDZ7EAw5Q=XAD3WtutwCHSgfiw-qQ5z4TcYCS@mail.gmail.com>
References: <Acuuu5ny+zlvst9wTH+OPBMrDizm+g==>
	<0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
	<AANLkTi=SDZ7EAw5Q=XAD3WtutwCHSgfiw-qQ5z4TcYCS@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B027084269764CECD9EA1@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 26, 2011 10:29 PM, Martin Guy wrote:
> On 7 January 2011 23:38, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>> The ep9307, ep9312, and ep9315 variants of the ep93xx processor include the
>> raster engine needed for framebuffer support.
>>
>> This allows the EDB93xx boards with those processors to use the framebuffer
>> driver.
>>
>> Tested on an EDB9307A with the following kernel parameters:
>> ? ? ? ?video=640x480-16 at 60
>> ? ? ? ?video=1024x768-16 at 60
>
> Hi. Sorry, I've been out of action for personal reasons.
>
> I don't have an edb to test this, but suggest you compare with the
> simone.c board file, which has similar code to enable the fb.
> Compared to the mainline code in 2.6.36, I use just one patch, which
> defines the working video modes. I attach it for reference.

The edb boards _are_ development boards, as such I really don't wish to limit the
modes that the framebuffer can be used with.

It's really up to the end user if the "twitching" at higher resolutions is an
issue.  For the dev boards I don't want to enforce any limitations.

Thanks,
Hartley
