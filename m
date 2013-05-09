From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 May 2013 15:40:55 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <518BABF0.7040201@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com>
 <518A8E6C.6070907@st.com> <20130509095143.GB7478@sirena.org.uk>
 <518B8F49.5020902@st.com> <20130509132600.GA3200@sirena.org.uk>
 <518BABF0.7040201@st.com>
Message-ID: <20130509144055.GF3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 03:00:16PM +0100, Srinivas KANDAGATLA wrote:

> Some of layouts of the sysconf registers are totally changed for each SOC.

> Looking at driver by driver maybe some drivers can take advantage of the
> patterns, but Am not sure if this will be a sustainable solution for all
> the drivers.

So what exactly is the driver doing then?  If the register maps look
nothing like each other then what's the common functionality the driver
is providing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130509/3a2e6598/attachment.sig>
