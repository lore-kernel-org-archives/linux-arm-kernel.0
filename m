From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 11:08:49 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <4F87F9C3.2010802@st.com>
References: <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com>
 <4F87ED74.8020308@st.com>
 <20120413091712.GE27730@b20223-02.ap.freescale.net>
 <20120413092615.GH24211@n2100.arm.linux.org.uk>
 <4F87F188.60603@st.com>
 <20120413093606.GI24211@n2100.arm.linux.org.uk>
 <4F87F9C3.2010802@st.com>
Message-ID: <20120413100848.GN3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 03:32:43PM +0530, Viresh Kumar wrote:

> Nodes, that don't need lookup stuff, can go ahead as earlier, just need
> to add _nolookup in existing routine name.

Or just have the core function handle NULL as a lookup array gracefully.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/24bcc1a6/attachment.sig>
