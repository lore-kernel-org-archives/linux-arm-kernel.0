From: davem@davemloft.net (David Miller)
Date: Wed, 12 Mar 2014 15:29:31 -0400 (EDT)
Subject: [PATCH net-next 7/9] xilinx: Convert uses of __constant_<foo>
 to <foo>
In-Reply-To: <2722ce785ea17ccd8bdbb20f0accd89232aa2b2a.1394644825.git.joe@perches.com>
References: <cover.1394644825.git.joe@perches.com>
 <2722ce785ea17ccd8bdbb20f0accd89232aa2b2a.1394644825.git.joe@perches.com>
Message-ID: <20140312.152931.1828799203352054913.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Wed, 12 Mar 2014 10:22:36 -0700

> The use of __constant_<foo> has been unnecessary for quite awhile now.
> 
> Make these uses consistent with the rest of the kernel.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
