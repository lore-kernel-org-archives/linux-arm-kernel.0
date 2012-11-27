From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 27 Nov 2012 09:56:16 +0800
Subject: [PATCH 01/27] usb: gadget: mv_udc: use udc_start and udc_stop
 functions
In-Reply-To: <20121126200621.GB15259@arwen.pp.htv.fi>
References: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
 <1353905020-29372-2-git-send-email-xiechao.mail@gmail.com>
 <20121126143936.GB6322@kroah.com>
 <20121126143431.GA19794@arwen.pp.htv.fi>
 <20121126184231.GB18590@kroah.com>
 <20121126200621.GB15259@arwen.pp.htv.fi>
Message-ID: <CADApbeiKn2S28Q50fGUgjhPUhmuh_mpYykvPCzahy1uAmUbWdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 4:06 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 26, 2012 at 10:42:32AM -0800, Greg KH wrote:
>> On Mon, Nov 26, 2012 at 04:34:31PM +0200, Felipe Balbi wrote:
>> > Hi,
>> >
>> > On Mon, Nov 26, 2012 at 06:39:36AM -0800, Greg KH wrote:
>> > > On Sun, Nov 25, 2012 at 11:43:14PM -0500, Chao Xie wrote:
>> > > > From: Chao Xie <chao.xie@marvell.com>
>> > > >
>> > > > This patches converts the driver into the new style start/stop
>> > > > interface. As a result the driver no longer uses the static
>> > > > global the_conroller variable.
>> > > >
>> > > > Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
>> > >
>> > > How come your signed-off-by address does not match your "From:" address
>> > > on the patch?  The marvell.com address should be both here, right?
>> >
>> > And how come I wasn't in Cc ???
>>
>> The author obviously didn't want the patches to actually be applied to
>> any tree :)
>
> sounds about right :-)
>
> --
> balbi

I am sorry about that. I will cc you in the second version of patches.
