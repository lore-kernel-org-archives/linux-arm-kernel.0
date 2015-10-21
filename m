From: joshc@ni.com (Josh Cartwright)
Date: Wed, 21 Oct 2015 05:32:43 -0500
Subject: [PATCHv2] fpga: zynq-fpga: Change fw format to handle bin
 instead of bit.
In-Reply-To: <1445361596-12024-2-git-send-email-moritz.fischer@ettus.com>
References: <1445361596-12024-1-git-send-email-moritz.fischer@ettus.com>
 <1445361596-12024-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20151021103243.GA30148@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 10:19:56AM -0700, Moritz Fischer wrote:
> This gets rid of the code to strip away the header and byteswap,
> as well as the check for the sync word.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>

Simpler is better.

Reviewed-by: Josh Cartwright <joshc@ni.com>

  Josh
