From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Feb 2014 13:01:02 -0600
Subject: [PATCH v12 1/4] PHY: Add function set_speed to generic PHY
 framework
In-Reply-To: <1393524848-8207-2-git-send-email-lho@apm.com>
References: <1393524848-8207-1-git-send-email-lho@apm.com>
 <1393524848-8207-2-git-send-email-lho@apm.com>
Message-ID: <20140227190102.GB4862@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 27, 2014 at 11:14:05AM -0700, Loc Ho wrote:
> This patch adds function set_speed to the generic PHY framework operation
> structure. This function can be called to instruct the PHY underlying layer
> at specified lane to configure for specified speed in hertz.

why ? looks like clk_set_rate() is your friend here. Can you be more
descriptive of the use case ? When will this be used ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/5b5f69ec/attachment-0001.sig>
