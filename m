From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 22 Jan 2015 02:46:35 +0100
Subject: [PATCH 1/9] power/reset: brcmstb: Make the driver buildable on
 MIPS
In-Reply-To: <1416962994-27095-2-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-2-git-send-email-cernekee@gmail.com>
Message-ID: <20150122014635.GM13715@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 25, 2014 at 04:49:46PM -0800, Kevin Cernekee wrote:
> Now that the driver doesn't use any ARM-specific headers, it is safe
> to build on MIPS or with COMPILE_TEST.

Thanks, applied.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150122/8e86ae8d/attachment.sig>
