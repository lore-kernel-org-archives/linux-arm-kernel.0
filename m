From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Oct 2011 22:00:08 +0530
Subject: [PATCH v3] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAGsJ_4x35qp+ELFY0vDX3PKSXhTe-POzqv+EO+jbB3ABxs_yrA@mail.gmail.com>
References: <1318844199-19303-1-git-send-email-Barry.Song@csr.com>
	<1318859861.23438.137.camel@vkoul-udesk3>
	<CAGsJ_4x35qp+ELFY0vDX3PKSXhTe-POzqv+EO+jbB3ABxs_yrA@mail.gmail.com>
Message-ID: <1318869008.23438.146.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-10-17 at 22:45 +0800, Barry Song wrote:
> @numf: Number of frames in this template.
> @frame_size: Number of chunks in a frame i.e, size of sgl[].
> 
> frame_size==1 means prima2 only support 1 chunk. numf > 0 means
> ylen(line number -1) is at least 0 and frame number is at least 1. 
How about adding note in your driver for this

-- 
~Vinod
