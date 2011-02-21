From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 21 Feb 2011 17:34:20 +0530
Subject: [PATCH V5 30/63] ST SPEAr: Replacing SIZE macro's with actual
	required size
In-Reply-To: <20110221115356.GN14495@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<38be663ab3e653d889d64005a86ed4dcf8661ae1.1295499395.git.viresh.kumar@st.com>
	<20110219180119.GR29493@n2100.arm.linux.org.uk>
	<4D62088D.7050205@st.com>
	<20110221110331.GJ14495@n2100.arm.linux.org.uk>
	<4D625013.3000204@st.com>
	<20110221115356.GN14495@n2100.arm.linux.org.uk>
Message-ID: <4D6254C4.9060506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2011 05:23 PM, Russell King - ARM Linux wrote:
> In which case, please only send the first 10, and make sure that they
> apply on top of my 'spear' branch.
> 
> Also note that there's some SPEAr patches queued in the 'fixes' branch
> which will be going upstream tonight.

Russell,

I have taken care of above two steps, but i have some doubt.
I have made changes at few places:
 - EMI driver: Changes according to your review comments.
 - Removed CLCD patch, as you mentioned that earlier.
 - fixed PLGPIO & EMI patch issue resolved, code has been put to individual patches
	and patch 57 removed completely.
 - PATCH 29 & 30 are placed at the top and changes made other individual patches

So sending only first 10 patches looks a bit insufficient to me? Would be better
to send all of them (leaving what you have already applied), so that they
apply cleanly at your end.

-- 
viresh
