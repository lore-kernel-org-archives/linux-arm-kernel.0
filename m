From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 15:12:57 +0200
Subject: [PATCH net-next v2 00/15] ARM: sun8i: r40: Add Ethernet support
In-Reply-To: <20180502.110617.304411895589508709.davem@davemloft.net>
References: <20180501161227.2110-1-wens@csie.org>
 <CAGb2v67HFb6eLBS4_9s_wJ5uWFeQdUtwn_NMJnm59UUDFBDJUA@mail.gmail.com>
 <20180502.110617.304411895589508709.davem@davemloft.net>
Message-ID: <20180503131257.rlqxetafejikmnji@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, May 02, 2018 at 11:06:17AM -0400, David Miller wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> Date: Wed, 2 May 2018 00:33:45 +0800
> 
> > I should've mentioned that patches 3 ~ 10, and only these, should go
> > through net-next. sunxi will handle the remaining clk, device tree, and
> > soc driver patches.
> 
> Ok, I just noticed this.
> 
> Why don't you just post those patches separately as a series on their
> own then, in order to avoid confusion?
> 
> Then you can adjust the patch series header posting to explain the
> non-net-next changes, where they got merged, and what they provide
> in order to faciliate the net-next changes.

I now that we usually have some feedback from non-net maintainers that
they actually prefer seeing the full picture (and I also tend to
prefer that as well) and having all the patches relevant to enable a
particular feature, even if it means getting multiple maintainers
involved.

Just to make sure we understood you fully, do you want Chen-Yu to
resend his serie following your comments, or was that just a general
remark for next time?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/ca25c556/attachment.sig>
