From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Nov 2015 08:40:44 -0600
Subject: Linus HEAD build break
In-Reply-To: <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
References: <871tc31atk.fsf@saruman.tx.rr.com>
 <87y4ebyznc.fsf@saruman.tx.rr.com>
 <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
Message-ID: <87vb9fyyvn.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Belisko Marek <marek.belisko@gmail.com> writes:
> Hi,
>
> On Fri, Nov 6, 2015 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
>>
>> Hi again,
>>
>> Felipe Balbi <balbi@ti.com> writes:
>>> Hi Marek,
>>>
>>> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
>>> subnode") breaks build on current linus/master (which current sits in
>>
>> this commit cannot be found in next. How come it's in linus/master ?
> I did post fix but Tony seems doesn't merge it:
> https://lkml.org/lkml/2015/10/13/816

looking at that thread, I have no idea how come the old version was
merged in the first place. Tony was clear that it broke build and yet
this patch has made its way to mainline and it didn't even go through
linux-next, which makes the problem worse.

Now we have a bisection point where the tree (well, some DTS files)
won't even build. This is quite messy.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/5d03b142/attachment.sig>
