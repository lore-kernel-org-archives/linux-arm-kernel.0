From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Aug 2013 08:55:02 -0400
Subject: [GIT PULL 1/2] ARM: mvebu: MSI/PCI changes for v3.12
In-Reply-To: <20130816062609.GF7035@quad.lixom.net>
References: <20130814191011.GD13964@titan.lakedaemon.net>
 <20130816062609.GF7035@quad.lixom.net>
Message-ID: <20130816125502.GR13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 11:26:09PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Wed, Aug 14, 2013 at 03:10:11PM -0400, Jason Cooper wrote:
> 
> >       PCI: msi: add default MSI operations for !HAVE_GENERIC_HARDIRQS platforms
> 
> I can't find this patch posted anywhere, and it lacks acks. For trivial code in
> your own subsystem that's sometimes ok, but this cuts across to PCI.

oops, you're right.  I've forwarded the email where Bjorn said the
change looked ok.  I missed that the original build failure didn't Cc:
any MLs.

thx,

Jason.
