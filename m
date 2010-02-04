From: davidb@quicinc.com (David Brown)
Date: Wed, 3 Feb 2010 16:09:49 -0800
Subject: [RFC 18/18] arm: mm: qsd8x50: Fix incorrect permission faults
In-Reply-To: <20100119171033.GA1323@shareable.org>
References: <20100111231143.GF7925@n2100.arm.linux.org.uk>
	<20100119171033.GA1323@shareable.org>
Message-ID: <20100204000949.GA22186@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 09:10:33AM -0800, Jamie Lokier wrote:

> --- /dev/null
> +++ b/Documentation/arm/msm/emulate_domain_manager.txt
> @@ -0,0 +1,282 @@
> +[... longish license header, like new BSD but different...

All of the license blurbs that made it under the documentation
directory were put there erroneously, and will be removed
entirely in future patches.  That license wasn't intended for
kernel documentation.

David
