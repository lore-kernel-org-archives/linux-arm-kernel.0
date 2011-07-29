From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 29 Jul 2011 08:40:00 -0700
Subject: [PATCH 10/18] dmaengine/amba-pl08x: Get rid of
	pl08x_pre_boundary()
In-Reply-To: <1311941980.1536.534.camel@vkoul-udesk3>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<c147ba3a755935e93fdb40b5531a6e18d34e0fd7.1311936524.git.viresh.kumar@st.com>
	<1311941980.1536.534.camel@vkoul-udesk3>
Message-ID: <CAOh2x==6m_UgWN=qour+0P1R7FrKvPHXy9Mu51U36br7vKHKUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/29/11, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
>> You can still issue bursts within the PL080 that are in excess o f 1KB.
>> The
> 								^^^^^^
> of

Ok.
