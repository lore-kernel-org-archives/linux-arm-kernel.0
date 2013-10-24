From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 16:19:56 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <af289ef3cc80be8de26274ba1f598d54.squirrel@twosheds.infradead.org>
References: <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <20131024122346.GD11296@ulmo.nvidia.com>
 <1382619655.6040.52.camel@sakura.staff.proxad.net>
 <516bfc7f9366ff3ef9187c36dd160888.squirrel@twosheds.infradead.org>
 <1382621431.6040.66.camel@sakura.staff.proxad.net>
 <af289ef3cc80be8de26274ba1f598d54.squirrel@twosheds.infradead.org>
Message-ID: <20131024141955.GB25061@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 02:05:58PM -0000, David Woodhouse wrote:
> 
> >
> > On Thu, 2013-10-24 at 13:10 +0000, David Woodhouse wrote:
> >
> >> Note that you are not describing a normal "DT scenario" here. You are
> >> describing a case in which we screwed up
> >
> > AKA "real world"
> 
> No. Absolutely not. That was a screwup, and it needs to be *rare*. The
> excuses you present for it are crappy and uunacceptable.

That's not helping. The fact is that is has happened. And we've handled
this in the past by just changing the DT bindings. Much of the current
frustration comes from the fact that things we used to be able to do
easily are now impossible.

While I agree that many of these screwups shouldn't have happened in the
first place, it's nothing that we were prepared for two years ago. At
some point everyone agreed that DT was the way forward, so DT is what we
did. Nobody said anything about stable ABI back then, so nobody cared.
We treated DT the same way we had treated platform data before, which
has inevitable lead to the current mess, which is only slightly better
than what we used to have.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/470d94f1/attachment.sig>
