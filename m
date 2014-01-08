From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 08 Jan 2014 09:01:55 -0800
Subject: [PATCH v2 0/8] clk: max77686: Clock provider implementation fixes
In-Reply-To: <3008563.6S2kFjQKp9@amdc1227>
References: <1386864441-19561-1-git-send-email-t.figa@samsung.com>
 <2890647.PEOApIOYyP@amdc1227> <20140108163138.27803.58310@quantum>
 <3008563.6S2kFjQKp9@amdc1227>
Message-ID: <20140108170155.27803.27478@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2014-01-08 08:44:29)
> On Wednesday 08 of January 2014 08:31:38 Mike Turquette wrote:
> > Quoting Tomasz Figa (2014-01-02 07:22:12)
> > > On Tuesday 31 of December 2013 11:42:15 Mike Turquette wrote:
> > > > Quoting Tomasz Figa (2013-12-12 08:07:13)
> > > > > This series intends to improve clock provider impementation of max77686
> > > > > PMIC driver. First two patches are simple fixes of current implementation
> > > > > to allow correct control of provided clocks. Further patches refactor
> > > > > the driver to make the code cleaner and prepare for further patches. Then
> > > > > last two patches add registration of OF clock provider and adjust device
> > > > > tree nodes of boards containing max77686 chip to contain properties
> > > > > required by clock provider.
> > > > 
> > > > Acked-by: Mike Turquette <mturquette@linaro.org>
> > > 
> > > Hmm... Shouldn't this series go through the clk tree directly? If not, who
> > > should be taking it?
> > 
> > Yes it should, but I guessed it would come in a pull request. Maybe Ack
> > is the wrong thing? I can just say "looks good to me me" or something
> > else.
> 
> Nah, I think Ack is completely right, but still this series is quite
> standalone, e.g. it does not really belong to samsung-clk nor any other
> clock subtree, so I thought you would be applying them directly.

True, this isn't really a samsung clock pull request. We can just
attribute this one to ironing out a few bugs in our workflow ;-)

> 
> I believe Lee has already applied this one, but in future, to avoid such
> confusion, if it's more convenient for you, I can send you any clock
> series as pull requests.

That is fine, and it would also be fine to state in the coverletter that
you do NOT plan to send a pull request. That removes all ambiguity from
my side and lets me know to pick the patches manually. Verbosity is
always good with these sorts of things.

Regards,
Mike

> 
> Best regards,
> Tomasz
> 
