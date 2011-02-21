From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 21 Feb 2011 12:09:09 +0530
Subject: [PATCH V5 30/63] ST SPEAr: Replacing SIZE macro's with actual
	required size
In-Reply-To: <20110219180119.GR29493@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<38be663ab3e653d889d64005a86ed4dcf8661ae1.1295499395.git.viresh.kumar@st.com>
	<20110219180119.GR29493@n2100.arm.linux.org.uk>
Message-ID: <4D62088D.7050205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2011 11:31 PM, Russell King - ARM Linux wrote:
> Same comments as the other patch changing to SZ_* macros.  Where possible
> fold these changes into the patch(es) which add the original definitions
> rather than having patches which add stuff and then separate patches
> which rework those patches.
> 

Ok.

> Could you do that and provide reworked patches please?  I'll publish the
> branch I've merged stuff onto thus far (but note that it's 'unstable'),
> but note that it won't contain the bits I've merged into the 'fixes'
> branch.

Ok. I will surely do that.

Just one question, should i send these patches to mailing list again or
directly to tracker?

-- 
viresh
