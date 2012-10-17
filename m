From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 17 Oct 2012 15:47:42 +0300
Subject: [PATCH 11/11] nand: Increase the ecc placement locations to 640
In-Reply-To: <67e0aae3b23f37feb30789f5c6cb342b5684911a.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <67e0aae3b23f37feb30789f5c6cb342b5684911a.1349778821.git.vipin.kumar@st.com>
Message-ID: <1350478062.5769.147.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-09 at 16:14 +0530, Vipin Kumar wrote:
> Few devices like H27UBG8T2CTR have a writesize/oobsize of 8KB/640B.
> This means that the maximum oobsize has gone up to 640 bytes and consequently
> the maximum ecc placement locations have also gone up to 640.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121017/508f73cf/attachment.sig>
