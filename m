From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Aug 2017 10:40:51 +0200
Subject: [PATCH v7 0/5] ARM: sunxi: Convert sun4i/sun7i series SoCs to
 sunxi-ng CCU
In-Reply-To: <cover.2a284ee63f45063ec7c0720b1098860e0b516c6d.1503507503.git-series.plaes@plaes.org>
References: <cover.2a284ee63f45063ec7c0720b1098860e0b516c6d.1503507503.git-series.plaes@plaes.org>
Message-ID: <20170824084051.gbb4z2jk4nwd6gja@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On Wed, Aug 23, 2017 at 08:23:28PM +0300, Priit Laes wrote:
> Hi,
> 
> This serie brings A10 (sun4i) and A20 (sun7i) SoCs into the
> sunxi-ng world. With this patchset we now support all the clocks
> in sun4i/sun7i SoCs.
> 
> In order to make cross-tree merges bisectable, changes to device
> trees are currently using clock index as numbers instead of defines.

Thanks a lot for your persistence. I just merged all of these, and
sent a PR for the clock changes to be merged.

Thanks again,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/3a729e98/attachment-0001.sig>
