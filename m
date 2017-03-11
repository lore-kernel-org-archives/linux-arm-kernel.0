From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sat, 11 Mar 2017 15:49:32 +0200
Subject: [PATCH v5 21/39] UAPI: Add media UAPI Kbuild file
In-Reply-To: <1489121599-23206-22-git-send-email-steve_longerbeam@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-22-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170311134931.GP3220@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Mar 09, 2017 at 08:53:01PM -0800, Steve Longerbeam wrote:
> Add an empty UAPI Kbuild file for media UAPI headers.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

The existing V4L2 UAPI headers are under include/uapi/linux. Could you use
that directory instead?

I actually wouldn't really object doing this but it should have been done in
2002 or so when the first V4L2 header was added. Now the benefit is
questionable.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
