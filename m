From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sun, 10 Jan 2016 01:03:30 +0200
Subject: [PATCH 0/8] [media] Check v4l2_of_parse_endpoint() ret val in
 all drivers
In-Reply-To: <1452191248-15847-1-git-send-email-javier@osg.samsung.com>
References: <1452191248-15847-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160109230330.GG576@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Thu, Jan 07, 2016 at 03:27:14PM -0300, Javier Martinez Canillas wrote:
> Hello,
> 
> When discussing a patch [0] with Laurent Pinchart for another series I
> mentioned to him that most callers of v4l2_of_parse_endpoint() weren't
> checking the return value. This is likely due the function kernel-doc
> stating incorrectly that the return value is always 0 but can return a
> negative error code on failure.
> 
> This trivial patch series fixes the function kernel-doc and add proper
> error checking in all the drivers that are currently not doing so.

After fixing patches 5 and 6,

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
