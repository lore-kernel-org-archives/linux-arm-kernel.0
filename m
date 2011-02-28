From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 28 Feb 2011 10:46:35 +0000
Subject: [PATCH 3/8 resend] dw_dmac: call dwc_scan_descriptor from
	dwc_issue_pending only if active list is empty
In-Reply-To: <8003205172278ef36cfca1fd50a54cb143fad958.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
	<8003205172278ef36cfca1fd50a54cb143fad958.1298889267.git.viresh.kumar@st.com>
Message-ID: <20110228104635.GB2754@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 04:11:18PM +0530, Viresh Kumar wrote:
> dwc_scan_descriptor was called even when there were descriptors in active list.
> Checking if active list is empty or not.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Hi Viresh,

I have a similar patch to this that is already in next that should 
achieve the same thing (dmaengine/dw_dmac: don't scan descriptors if no 
xfers in progress).

Jamie
