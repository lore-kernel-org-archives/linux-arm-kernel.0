From: bp@alien8.de (Borislav Petkov)
Date: Mon, 29 Aug 2016 10:05:30 +0200
Subject: [Patch v4 9/9] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <20160829063448.GA32489@tiger>
References: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
 <20160812091354.GB333@nazgul.tnic> <20160829063448.GA32489@tiger>
Message-ID: <20160829080530.GA25468@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 02:34:48PM +0800, Shawn Guo wrote:
> Is it mandatory to have DTS changes go with driver part altogether?

Yes, because the EDAC driver needs them to even load properly.

> Otherwise, I prefer to have them go through separate tree.

Any particular reason why you prefer that?

We've been doing this for other ARM EDAC drivers already and there were
no issues whatsoever.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
