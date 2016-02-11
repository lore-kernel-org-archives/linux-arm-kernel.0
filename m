From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 11 Feb 2016 18:34:28 +0100
Subject: [PATCH 2/7] i2c: omap: Fix PM regression with deferred probe for
 pm_runtime_reinit
In-Reply-To: <1455145370-20301-3-git-send-email-tony@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-3-git-send-email-tony@atomide.com>
Message-ID: <20160211173427.GB1524@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Wolfram, I'd like to merge this along with other related fixes via
> the ARM SoC tree if no objections, please review and ack if this
> look OK to you.

Well, since most patches seem to be picked up individually now, I'd
prefer to do the same. This is v4.5 material, or?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/1252e49f/attachment.sig>
