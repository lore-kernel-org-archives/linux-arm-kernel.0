From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 13:09:52 +0000
Subject: [PATCH V5 30/63] ST SPEAr: Replacing SIZE macro's with actual
	required size
In-Reply-To: <4D6254C4.9060506@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<38be663ab3e653d889d64005a86ed4dcf8661ae1.1295499395.git.viresh.kumar@st.com>
	<20110219180119.GR29493@n2100.arm.linux.org.uk>
	<4D62088D.7050205@st.com>
	<20110221110331.GJ14495@n2100.arm.linux.org.uk>
	<4D625013.3000204@st.com>
	<20110221115356.GN14495@n2100.arm.linux.org.uk>
	<4D6254C4.9060506@st.com>
Message-ID: <20110221130952.GO14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 05:34:20PM +0530, viresh kumar wrote:
> On 02/21/2011 05:23 PM, Russell King - ARM Linux wrote:
> > In which case, please only send the first 10, and make sure that they
> > apply on top of my 'spear' branch.
> > 
> > Also note that there's some SPEAr patches queued in the 'fixes' branch
> > which will be going upstream tonight.
> 
> Russell,
> 
> I have taken care of above two steps, but i have some doubt.
> I have made changes at few places:
>  - EMI driver: Changes according to your review comments.
>  - Removed CLCD patch, as you mentioned that earlier.
>  - fixed PLGPIO & EMI patch issue resolved, code has been put to individual patches
> 	and patch 57 removed completely.
>  - PATCH 29 & 30 are placed at the top and changes made other individual patches
> 
> So sending only first 10 patches looks a bit insufficient to me? Would be better
> to send all of them (leaving what you have already applied), so that they
> apply cleanly at your end.

I don't know, and I'm getting to the point of giving up with this SPEAr
stuff.  It's more trouble and time consuming than it's worth because of
the size of the patch set.  It's just *too* large to properly deal with.
