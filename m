From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 00:07:29 +0100
Subject: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
In-Reply-To: <2437793.vfcRUkFCet@vostro.rjw.lan>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-3-git-send-email-broonie@kernel.org>
 <CAKohpo=4c=eDOMxxFi37mLA7LViJ-P_Rb42Yt5ARa_qgiGU8eg@mail.gmail.com>
 <2437793.vfcRUkFCet@vostro.rjw.lan>
Message-ID: <20140519230729.GD30457@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 01:19:03AM +0200, Rafael J. Wysocki wrote:

> I've queued this one up for 3.16, thanks!

This will fail to build without patch 1 - it uses the stubs added there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/8c3b3bce/attachment.sig>
