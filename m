From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Feb 2013 08:20:15 -0500
Subject: [GIT PULL  3/4] ARM: mvebu: boards for v3.9
In-Reply-To: <20130205232604.GB14851@quad.lixom.net>
References: <pull-1359733919-342140> <1359733919.c3D01c3.22262@triton>
 <20130205071010.GD13049@quad.lixom.net>
 <20130205112104.GP14746@titan.lakedaemon.net>
 <20130205182333.GA21051@quad.lixom.net>
 <20130205183050.GZ14746@titan.lakedaemon.net>
 <20130205232604.GB14851@quad.lixom.net>
Message-ID: <20130206132015.GB14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 03:26:04PM -0800, Olof Johansson wrote:
> What makes sense is to hold off the patches that adds dts entries and
> removes the platform device registrations to the next release to avoid
> this dependency.

Hmm, this makes life a *lot* simpler, but it also really slows things
down.  I'll go ahead and do this from now on.

Would you like me to redo /boards and /dt in light of this, or just do
it from here forward?

thx,

Jason.
