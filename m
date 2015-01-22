From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 22 Jan 2015 02:46:58 +0100
Subject: [PATCH 2/9] power/reset: brcmstb: Use the DT "compatible" string
 to indicate bit positions
In-Reply-To: <1416962994-27095-3-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-3-git-send-email-cernekee@gmail.com>
Message-ID: <20150122014657.GN13715@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 25, 2014 at 04:49:47PM -0800, Kevin Cernekee wrote:
> Some of the older chips used different bits to arm and trigger the reset.
> Add the infrastructure needed to specify this through the "compatible"
> string.

Thanks, applied.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150122/873c7223/attachment.sig>
