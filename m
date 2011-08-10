From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Aug 2011 08:57:42 +0530
Subject: [PATCH 2/6] spi/spi-pl022: Use GFP_NOWAIT for allocation from
	tasklet
In-Reply-To: <CABb+yY3CuYqNcpvdP8fa6FsaN3EBDAXivKSP56gRh6-oPyp2Mg@mail.gmail.com>
References: <cover.1312887860.git.viresh.kumar@st.com>	<cb966698764017627e85a4c85d1d781cf3fc9819.1312887860.git.viresh.kumar@st.com>
	<CABb+yY3CuYqNcpvdP8fa6FsaN3EBDAXivKSP56gRh6-oPyp2Mg@mail.gmail.com>
Message-ID: <4E41FAAE.40907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2011 04:56 PM, Jassi Brar wrote:
> Since this could be called from when we actually need the transfer start,
> maybe we could try harder using GFP_ATOMIC instead ?

Yes. Will do it.

-- 
viresh
