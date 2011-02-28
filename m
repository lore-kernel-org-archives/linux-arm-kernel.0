From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 28 Feb 2011 16:28:17 +0530
Subject: [PATCH 3/8 resend] dw_dmac: call dwc_scan_descriptor from
	dwc_issue_pending only if active list is empty
In-Reply-To: <20110228104635.GB2754@pulham.picochip.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
	<8003205172278ef36cfca1fd50a54cb143fad958.1298889267.git.viresh.kumar@st.com>
	<20110228104635.GB2754@pulham.picochip.com>
Message-ID: <4D6B7FC9.4020905@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2011 04:16 PM, Jamie Iles wrote:
> On Mon, Feb 28, 2011 at 04:11:18PM +0530, Viresh Kumar wrote:
>> > dwc_scan_descriptor was called even when there were descriptors in active list.
>> > Checking if active list is empty or not.
>> > 
>> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Hi Viresh,
> 
> I have a similar patch to this that is already in next that should 
> achieve the same thing (dmaengine/dw_dmac: don't scan descriptors if no 
> xfers in progress).

Jamie,

Sorry for missing that!!
This patch can be dropped.

-- 
viresh
