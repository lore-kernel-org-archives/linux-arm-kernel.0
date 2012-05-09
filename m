From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 9 May 2012 16:10:36 +0200
Subject: [PATCH] mfd: da9052: fix of_match_node() arguments
In-Reply-To: <1336258968-6423-1-git-send-email-olof@lixom.net>
References: <1336258968-6423-1-git-send-email-olof@lixom.net>
Message-ID: <20120509141036.GF1794@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Sat, May 05, 2012 at 04:02:48PM -0700, Olof Johansson wrote:
> The driver calls of_match_node() with the arguments swapped.
Thanks, patch applied to my for-next branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
