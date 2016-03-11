From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Mar 2016 11:58:29 +0100
Subject: [PATCH 2/5] dmaengine: sun6i: Fix impossible settings of burst
 and bus width
In-Reply-To: <caa86759ff67df73c10fc3738eac5de58d582cc1.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
 <caa86759ff67df73c10fc3738eac5de58d582cc1.1457606136.git.moinejf@free.fr>
Message-ID: <20160311105829.GB8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:27:37AM +0100, Jean-Francois Moine wrote:
> In the commit 1f9cd915b64bb95f "dmaengine: sun6i: Fix memcpy operation",

The commit title should be enclosed in parenthesis.

> the signed values returned by convert_burst() and convert_buswidth()
> were stored in an unsigned value.
> Then, these values were considered as errors when non null.
> As a result, setting burst or buswidth to values different from 1 was
> making the DMA transfers to be rejected.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Otherwise, Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/98f60af3/attachment.sig>
