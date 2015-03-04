From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 05 Mar 2015 00:43:13 +0100
Subject: [PATCH 1/6] ARM: at91: switch to multiplatform
In-Reply-To: <20150304233558.GK3989@piout.net>
References: <1425480446-31711-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425480446-31711-2-git-send-email-alexandre.belloni@free-electrons.com>
 <1425511307.2090.60.camel@tiscali.nl> <20150304233558.GK3989@piout.net>
Message-ID: <1425512593.2090.69.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni schreef op do 05-03-2015 om 00:35 [+0100]:
> On 05/03/2015 at 00:21:47 +0100, Paul Bolle wrote :
> > Utterly trivial, but anyhow. Could you please make this
> >     bool
> > 
> > line to be the line directly following the line reading
> >     config ARCH_AT91
> > 
> > above? 
> 
> I can definitely do that, is your parser relying on it? :)

No, I don't think it is, actually.

But nearly all Kconfig entries have their type as their first option
(and help as their last item, I might add). So I was mainly thinking
about human readers and people writing quick scripts, etc.

Thanks,


Paul Bolle
