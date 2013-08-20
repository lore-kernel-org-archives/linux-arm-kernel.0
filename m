From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 20 Aug 2013 16:09:26 +0900
Subject: [PATCH v2 0/8] Common Clock Framework support for Samsung
 S3C64xx
In-Reply-To: <20130820002258.4443.34197@quantum>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <2956608.dyLtqySMuJ@amdc1227> <20130816210203.4443.43511@quantum>
 <3890424.fJfWX17mED@flatron> <158901ce9b34$c0ac8720$42059560$@org>
 <20130820002258.4443.34197@quantum>
Message-ID: <18f101ce9d74$34e23450$9ea69cf0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette wrote:
> 

[...]

> > OK, if new branch is ready, I will replace with that or if re-merge is
> > required, I will. Either way, I'm fine and can handle. Mike, let me know
> > your choice :-)
> 
> Since I have already published it let's just go with the delta patch.  I
> can create another stable branch named clk-next-s3c64xx-delta that just
> has this patch on top of clk-next-s3c64xx OR I can apply it on top of
> the existing clk-next-s3c64xx and re-merge it.
> 
Sounds good to me. If the branch for the delta is ready, let me know.

> I'm trying to think on whether there are any weird git corner cases with
> re-merging clk-next-s3c64xx. Let me know if re-merging is somehow unsafe
> (makes history weird, or whatever).
> 
I don't think it causes some problem.

> Let me know what option is better for you. I'll publish as soon as I get
> the delta patch. Apologies again for creating some extra work!
> 
No problem.

Thanks,
Kukjin
