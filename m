From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 3 Mar 2016 22:14:18 +0100
Subject: [PATCH] drivers: i2c: Fix qup fifo handling
In-Reply-To: <1456502334-8687-1-git-send-email-sricharan@codeaurora.org>
References: <1456502334-8687-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160303211418.GA1501@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 09:28:54PM +0530, Sricharan R wrote:
> After the addition of V2 support, there was a regression observed
> when testing it on MSM8996. The reason is driver puts the controller
> in to RUN state and writes the data to be 'tx' ed in fifo. But controller
> has to be put in to 'PAUSE' state and data has to written to fifo. Then
> should be put in to 'RUN' state separately.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Changed the subject to "i2c: qup: Fix fifo handling after adding V2
support". Please note the prefixes and the more detailed description.

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160303/01126608/attachment.sig>
