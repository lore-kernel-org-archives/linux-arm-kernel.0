From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 11:51:06 +0200
Subject: [PATCH v2 2/4] ARM: tegra: Add resets & has-utmi-pad-registers
 flag to all USB PHYs
In-Reply-To: <53BEAD70.5010504@nvidia.com>
References: <1404436179-10745-1-git-send-email-ttynkkynen@nvidia.com>
 <1404436179-10745-3-git-send-email-ttynkkynen@nvidia.com>
 <53BEAD70.5010504@nvidia.com>
Message-ID: <20140714095105.GA9870@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 06:12:48PM +0300, Tuomas Tynkkynen wrote:
> Thierry,
> 
> Since Stephen's on a vacation, I'd like to double-check with you that the DT
> changes looks good. Greg has applied these to the USB tree today.

Yes, looks sane to me. Not sure how much people will like to see the DTS
changes go in through the USB tree, but I don't see a lot of potential
for conflicts, so chances are nobody will notice anyway.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/077a8483/attachment.sig>
