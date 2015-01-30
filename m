From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 30 Jan 2015 12:43:12 +0100
Subject: [PATCH V9 12/14] drm/bridge: Add i2c based driver for
 ps8622/ps8625 bridge
In-Reply-To: <CAEC9eQMv_qbQJ=DKz=KznxkGbE2O08DUTwSDtpcfZeHtesEewA@mail.gmail.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-13-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQMv_qbQJ=DKz=KznxkGbE2O08DUTwSDtpcfZeHtesEewA@mail.gmail.com>
Message-ID: <20150130114308.GD32359@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 08:12:20PM +0530, Ajay kumar wrote:
> Hi Thierry,
> 
> I think you forgot to take this patch!
> Can you check this?

Yes, I missed it somehow. It didn't build for me after applying it now,
but I fixed that up (and a few sparse warnings along with it). I'll send
out another pull request shortly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/8202edd9/attachment.sig>
