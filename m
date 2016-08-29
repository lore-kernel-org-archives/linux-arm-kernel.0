From: bp@alien8.de (Borislav Petkov)
Date: Mon, 29 Aug 2016 15:51:30 +0200
Subject: [Patch v4 9/9] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <20160829083350.GL30790@tiger>
References: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
 <20160812091354.GB333@nazgul.tnic> <20160829063448.GA32489@tiger>
 <20160829080530.GA25468@nazgul.tnic> <20160829083350.GL30790@tiger>
Message-ID: <20160829135130.GB28806@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 04:33:50PM +0800, Shawn Guo wrote:
> To avoid potential merge conflicts. 

Haven't heard of any so far. And I don't see how adding 1 or 2 DT
entries more per driver is a serious merge conflict.

> Unless there are hard dependencies like making it compile, avoiding
> regression or maintaining bisect, patches should go through their
> established subsystem/architecture tree.

Well, doh, the driver simply doesn't work. How are people even supposed
to test the EDAC tree?

Why is it even such a big deal if it is acked by the proper maintainers?
Cross-tree maintainer acking happens all the time. So don't tell me the
merge conflicts are your big issue with this.

> Luckily.  If there are many patches on architecture DT branch changing
> the same file, when driver branch and DT branch merges in upstream
> branch, there will likely be merge conflicts.

So? There are tools to resolve those. And again, the DT changes for
EDAC are basically adding blocks so resolving those conflicts should be
trivial most of the time.

So no, I don't consider the potential merge conflicts an issue here.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
