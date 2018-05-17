From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 15:38:06 +0900
Subject: [PATCH 43/45] sound/soc/zte: remove duplicate includes
In-Reply-To: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-ID: <20180517063806.GN20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 12:02:03AM +0530, Pravin Shedge wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/4fdcdff7/attachment-0001.sig>
