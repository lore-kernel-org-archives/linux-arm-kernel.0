From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 18 Jun 2013 11:28:08 -0700
Subject: [PATCH 3/3] clk: tegra: T114: add DFLL DVCO reset control
In-Reply-To: <alpine.DEB.2.02.1306172019270.17176@utopia.booyaka.com>
References: <20130607121505.21868.72360.stgit@dusk.lan>
 <20130607121901.21868.65416.stgit@dusk.lan> <51B21105.1080301@wwwdotorg.org>
 <alpine.DEB.2.02.1306071703050.7753@utopia.booyaka.com>
 <51B6D239.5030905@nvidia.com>
 <alpine.DEB.2.02.1306110944130.22645@utopia.booyaka.com>
 <20130616042256.7541.7096@quantum>
 <alpine.DEB.2.02.1306172019270.17176@utopia.booyaka.com>
Message-ID: <20130618182808.9136.26244@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Paul Walmsley (2013-06-17 13:22:48)
> Hi,
> 
> On Sat, 15 Jun 2013, Mike Turquette wrote:
> 
> > These patches appear fine to me but I did not see any Acks, nor could I
> > tell if a v2 was necessary based on the comments. Will there be another
> > version?
> 
> I'm not planning to do another version at this time.

Thanks for clarifying.  I couldn't tell based on the discussion.

Anyways I've taken these into clk-next now.  There is not maintainer for
that directory as you pointed out, so no need to wait for Acks.

Regards,
Mike

> 
> > If not an Acked-by or Reviewed-by would be cool.
> 
> Hmm, not sure who the right people would be.  Looks like the 
> drivers/clk/tegra directory is unmaintained, so not sure who could ack it?
> 
> Peter or Stephen, care to review these patches and send a Reviewed-by?
> 
> 
> - Paul
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
