From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 17 Oct 2012 15:47:46 +0300
Subject: [PATCH 06/11] fsmc/nand: Modify the wait to uninterruptible
In-Reply-To: <3dcb002d0ad03dde9a91e8128dbaa320b8a264a9.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <3dcb002d0ad03dde9a91e8128dbaa320b8a264a9.1349778821.git.vipin.kumar@st.com>
Message-ID: <1350478066.5769.149.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-09 at 16:14 +0530, Vipin Kumar wrote:
> Interruptible wait caused trouble in fsmc hardware state machine if the
> application was killed abruptly. To make fsmc operation safe turn wait in to
> un-interruptible.
> 
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>

Pushed this one to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121017/59249ec7/attachment-0001.sig>
