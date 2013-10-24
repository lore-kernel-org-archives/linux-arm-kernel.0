From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 16:47:44 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131024143251.GA4096@netboy>
References: <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <20131024122346.GD11296@ulmo.nvidia.com>
 <1382619655.6040.52.camel@sakura.staff.proxad.net>
 <516bfc7f9366ff3ef9187c36dd160888.squirrel@twosheds.infradead.org>
 <1382621431.6040.66.camel@sakura.staff.proxad.net>
 <af289ef3cc80be8de26274ba1f598d54.squirrel@twosheds.infradead.org>
 <20131024141955.GB25061@ulmo.nvidia.com>
 <20131024143251.GA4096@netboy>
Message-ID: <20131024144743.GB9044@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 04:32:52PM +0200, Richard Cochran wrote:
> On Thu, Oct 24, 2013 at 04:19:56PM +0200, Thierry Reding wrote:
> > 
> > While I agree that many of these screwups shouldn't have happened in the
> > first place, it's nothing that we were prepared for two years ago. At
> > some point everyone agreed that DT was the way forward, so DT is what we
> > did. Nobody said anything about stable ABI back then, so nobody cared.
> 
> The idea of a device tree has not changed. I guess the arm crowd
> jumped on the DT bandwagon with no clue what it was about.

Yes, that's what I'm saying. I've played my part in it, too. Perhaps it
was obvious from the beginning and I just didn't notice, but no document
about DT that I read mentioned anything about ABI stability and such.
Then again I reckon none of the other DT implementations can really be
compared to Linux in terms of diversity and perhaps even number of
contributors. So perhaps a lot of the things that we now run into were
implied but never explicitly mentioned. Or I and most of the others
missed them.

> > We treated DT the same way we had treated platform data before, which
> > has inevitable lead to the current mess, which is only slightly better
> > than what we used to have.
> 
> So, are you saying that arm/dt is a failure?

Yeah, I think it is in some regards. But I wouldn't go as far as to call
it a total failure. I still think we can make it work, and even
reasonably well. We just need to fix our process. Perhaps we need to
start by documenting things better, such as what you can and can't do to
stable bindings and point people to that documentation.

Furthermore I don't think anyone has proposed a better alternative. ACPI
or UEFI have been mentioned, but are they really any superior? From what
I can tell they have all the same problems that we now face with DT as
well, so we might as well just stick with DT.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/cdfbf978/attachment.sig>
