From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 08 Jan 2014 13:54:32 -0800
Subject: [PATCH v2 0/8] clk: max77686: Clock provider implementation fixes
In-Reply-To: <4160932.uvjJSNcuKL@amdc1227>
References: <1386864441-19561-1-git-send-email-t.figa@samsung.com>
 <20140108171544.GC14575@lee--X1> <20140108175939.27803.30462@quantum>
 <4160932.uvjJSNcuKL@amdc1227>
Message-ID: <20140108215432.27803.3120@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2014-01-08 10:04:57)
> On Wednesday 08 of January 2014 09:59:39 Mike Turquette wrote:
> > Quoting Lee Jones (2014-01-08 09:15:44)
> > > > I believe Lee has already applied this one, but in future, to avoid such
> > > > confusion, if it's more convenient for you, I can send you any clock
> > > > series as pull requests.
> > > 
> > > Me? I haven't applied any clk patches.
> > 
> > I have taken patches 1-7 into clk-next just now.
> 
> Thanks.
> 
> > I can take patch #8 as
> > well but it would probably be better to send it through arm-soc?
> 
> Hmm, patch 8 is trivial enough to not cause any merge conflicts, but since
> it's unlikely that any users depending on introduced changes will show up
> for 3.14 it shouldn't really matter which tree it goes through...

In the absence of any strong opinion on the topic I have taken patch #8
into clk-next for 3.14.

Regards,
Mike

> 
> Best regards,
> Tomasz
> 
