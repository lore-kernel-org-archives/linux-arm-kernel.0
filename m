From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 17 Oct 2012 15:31:49 +0300
Subject: [PATCH 03/11] fsmc/nand: Support multiple banks connected to
 controller
In-Reply-To: <9748ce2483f539fb32279b8ea9df065cfdbe8ab1.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <9748ce2483f539fb32279b8ea9df065cfdbe8ab1.1349778820.git.vipin.kumar@st.com>
Message-ID: <1350477109.5769.141.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-09 at 16:14 +0530, Vipin Kumar wrote:
> Support up to max_banks number of banks in fsmc driver.
> 
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>

I tried to apply this, but it does not apply cleanly to l2-mtd.git,
which is based on 3.7-rc1.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121017/8034920f/attachment.sig>
