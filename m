From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Sep 2015 08:04:53 -0700
Subject: [PATCH v2 0/6] regulator: Fix pbias regulator enable
In-Reply-To: <55E81117.2040900@ti.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
 <CAPDyKFrVR+vvmxm43hGimjqo4pcFa1pfDuNNENXU-tk_qXo2=w@mail.gmail.com>
 <55E81117.2040900@ti.com>
Message-ID: <20150903150452.GT4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [150903 02:25]:
> On Thursday 03 September 2015 01:09 PM, Ulf Hansson wrote:
> > 
> > Finally, perhaps it's better if we queue this through my mmc tree
> > since we would then be able to avoid the regression - if I put
> > $subject patchset before [1], right? Then I need an ack from Mark for
> > the regulator patch.
> > Please tell me if you guys prefer another way.

That works for me too. Or Mark can set up an immutable signed
branch that you can merge in, up to you guys.

It's still going to break git bisect for booting but
removes the regression when mergeing to mainline.

I'd squash all the one liner dts changes into a single
patch though when applying to cut down on the commit
noise.

Regards,

Tony
