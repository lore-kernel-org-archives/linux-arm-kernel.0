From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 23:47:03 -0400 (EDT)
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <CAOesGMgiO+yY9rvADMizsBMKEsUo8+i=BsG_Z5-h02Gi+7Mriw@mail.gmail.com>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
 <20130814055800.GG16635@quad.lixom.net>
 <alpine.LFD.2.03.1308141018140.14472@syhkavp.arg>
 <20130814200834.GA24544@quad.lixom.net>
 <alpine.LFD.2.03.1308141621430.14472@syhkavp.arg>
 <CAOesGMgiO+yY9rvADMizsBMKEsUo8+i=BsG_Z5-h02Gi+7Mriw@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1308142338550.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Olof Johansson wrote:

> On Wed, Aug 14, 2013 at 1:40 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
> >> The reason I'm asking is that I applied this on next/soc instead of
> >> vexpress/mcpm, and we're asking downstream maintainers to not base anthing on
> >> next/* branches because it _might_ happen that we rebuild them.
> >
> > Looking into my inbox, I have the following emails from Lorenzo:
> >
> >   http://article.gmane.org/gmane.linux.power-management.general/36794
> >
> >   http://article.gmane.org/gmane.linux.power-management.general/37006
> >
> >   http://article.gmane.org/gmane.linux.power-management.general/37007
> >
> >   http://article.gmane.org/gmane.linux.ports.arm.kernel/260441
> >
> > You apparently were CC'd on all of them, and Lorenzo asked you on two
> > occasions how you wanted to handle this, and one of them is an explicit
> > pull request addressed to you.
> 
> Ok. I was well aware of the cpuidle series, the reason for why I was
> asking was that it was unclear if you were referring to that or
> something else beyond that.

No, it's only the cpuidle series... for now.


Nicolas
