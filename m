From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 24 Jul 2013 19:42:58 +0100
Subject: Requirements for FDT load address on ARM
In-Reply-To: <20130724171826.GX11072@mudshark.cambridge.arm.com>
References: <1374677923.6623.194.camel@hastur.hellion.org.uk>
 <alpine.LFD.2.03.1307241116200.15022@syhkavp.arg>
 <20130724171826.GX11072@mudshark.cambridge.arm.com>
Message-ID: <1374691378.32286.17.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-24 at 18:18 +0100, Will Deacon wrote:
> FWIW, you could have a look at what I do in kvmtool. It's not perfect, but
> I couldn't come up with anything better:
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/kvmtool.git/tree/tools/kvm/arm/fdt.c?h=kvmtool/master
> 
> (see the load_flat_binary function)

Thanks, it's most probably a good idea for us to do the same thing.

Ian.
