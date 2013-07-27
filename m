From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 27 Jul 2013 20:31:01 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <51F39FD8.6080808@broadcom.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <CAOesGMhEr3DiFm5uSgoHPFUMY4jWu4HkeTU2UmOGj=dS75Vk+g@mail.gmail.com>
 <20130727050406.GB4221@netboy> <2007664.vYsECFSKrV@flatron>
 <51F39FD8.6080808@broadcom.com>
Message-ID: <20130727183059.GD4813@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 12:24:24PM +0200, Arend van Spriel wrote:
> 
> That is a nice summary of how we got from null to now and Richard
> seems to be simply saying: let's stop mucking about and make this a
> project with a well-defined process of dealing with staging and
> stable bindings and keep stable bindings stable.

Yes, that is right.

Frankly, I am really surprised and shocked at the cavalier attitude
expressed here WRT DT bindings in released kernels. Think about the
*users* of this code. Not everyone working with ARM Linux is a kernel
developer or a DT guru. There is really no indication at all that the
ARM Linux DT stuff released so far are not stable and trustworthy.

It is not nice to provide such a mess, and the idea that we *must*
have a mess because the whole system in still in development is bogus,
IMHO. Just make sure that the mainline kernel is really working and
that the DT bindings *there* are for keeps.

It is your job as kernel developers.

Thanks,
Richard
