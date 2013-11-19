From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 18:39:43 +0000
Subject: [PATCH 1/2] ASoC: ab8500: Revert "ASoC: ab8500: Explicitly set
 I/O up"
In-Reply-To: <1384858698-19027-1-git-send-email-lee.jones@linaro.org>
References: <1384858698-19027-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20131119183943.GE2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 10:58:17AM +0000, Lee Jones wrote:
> This reverts commit 2245e3c31c15c2d2a26926c4b734f4d3a37ae252, as it
> is one of two patches which stop audio from working on Snowball.

As discussed in person someone with access to the hardware really needs
to figure out what's going on here properly since this code does need to
be fixed, the ASoC level register I/O code is going away - I'm aiming
for the next merge window all being well.  I've applied both squashed
together for v3.13 though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/54503115/attachment.sig>
