From: gioh.kim@lge.com (Gioh Kim)
Date: Fri, 3 Jan 2014 09:39:31 +0900
Subject: ARM: mm: Could I change module space size or place modules in
 vmalloc area?
In-Reply-To: <20140102101359.GU6589@tarshish>
References: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
 <20140102101359.GU6589@tarshish>
Message-ID: <002e01cf081c$44a11e70$cde35b50$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for reply.

> -----Original Message-----
> From: Baruch Siach [mailto:baruch at tkos.co.il]
> Sent: Thursday, January 02, 2014 7:14 PM
> To: Gioh Kim
> Cc: Russell King; linux-mm at kvack.org; linux-arm-kernel; HyoJun Im
> Subject: Re: ARM: mm: Could I change module space size or place modules in
> vmalloc area?
> 
> Hi Gioh,
> 
> On Thu, Jan 02, 2014 at 07:04:13PM +0900, Gioh Kim wrote:
> > I run out of module space because I have several big driver modules.
> > I know I can strip the modules to decrease size but I need debug info
> now.
> 
> Are you sure you need the debug info in kernel memory? I don't think the
> kernel is actually able to parse DWARF. You can load stripped binaries
> into the kernel, and still use the debug info with whatever tool you have.

I agree you but driver developers of another team don't agree.
I don't know why but they say they will strip drivers later :-(
So I need to increase modules space size.


> 
> baruch
> 
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open
Systems
> =}------------------------------------------------ooO--U--Ooo------------
> {=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
