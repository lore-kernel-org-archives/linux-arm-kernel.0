From: broonie@sirena.org.uk (Mark Brown)
Date: Thu, 27 Aug 2009 14:14:05 +0100
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <24498970.196691251371216483.JavaMail.weblogic@epml12>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
Message-ID: <20090827131405.GB12506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2009 at 11:06:56AM +0000, Jinsung Yang wrote:

[Reflowed into 80 columns - you might want to fix your MUA to do this,
it makes things much more legible.]

> So that, we are considering the following platform structure to manage
> our new SoCs.  (All names are tentative)

It might be easier to think about this in terms of how it integrates
with the existing Samsung CPU support - what are the changes to the
current structure and how will the new CPUs slot into that structure?
Although...

> We hope and need to discuss our ideas more and more, continuously, so
> tell us your opinions and something like this freely about this and,
> because s3c6410 supports is already in the mainline, we should handle
> this SoC specially.

It would seem to be much better to integrate your work with the existing
support for your CPUs rather than starting from scratch - there's an
awful lot of continuity in the IPs and it'd seem strange to ignore that.
What are the factors that are pushing you towards starting from scratch?

> Finally, we should talk with Ben Dooks who is a maintainer of s3c24xx
> series, so hope Ben's reply especially :)

You probably want to CC him on messages like this - I've added him here.
