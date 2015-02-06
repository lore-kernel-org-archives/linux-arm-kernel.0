From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Feb 2015 07:50:44 +0800
Subject: [PATCH 0/4] ASoC: samsung: clean up references to outdated
 Kconfig symbols
In-Reply-To: <1421664067.9655.51.camel@x220>
References: <1421664067.9655.51.camel@x220>
Message-ID: <20150206235044.GO31311@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 11:41:07AM +0100, Paul Bolle wrote:
> A few series of ARM cleanups regarding S5PC100 and S5PV210 were included
> in v3.17. These series removed these five Kconfig symbols:
>     MACH_AQUILA
>     MACH_GONI
>     MACH_SMDKC100
>     MACH_SMDKC110
>     MACH_SMDKV210
> 
> This series, done on top of next-20150119, removes the remaining

If you are posting a patch series please ensure that all the patches in
the series are threaded in reply to the cover letter (or first patch if
there isn't one) so that mail clients can see to display them as a
series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/5edb3dc8/attachment-0001.sig>
