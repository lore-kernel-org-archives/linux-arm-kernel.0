From: htejun@gmail.com (Tejun Heo)
Date: Wed, 29 Oct 2014 11:19:28 -0400
Subject: [percpu] Convert remaining __get_cpu_var uses in 3.18-rcX
In-Reply-To: <alpine.DEB.2.11.1410271047400.17089@gentwo.org>
References: <alpine.DEB.2.11.1410271047400.17089@gentwo.org>
Message-ID: <20141029151928.GE25226@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 10:49:45AM -0500, Christoph Lameter wrote:
> During the 3.18 merge period additional __get_cpu_var uses were
> added. The patch converts these to this_cpu_ptr().
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>

Applied to percpu/for-3.19.

Thanks.

-- 
tejun
