From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 2 Apr 2013 09:38:30 +0100
Subject: [PATCH] ARM: ux500: update V-INTCORE constraints
In-Reply-To: <CACRpkdYgCxf9R1aU2QdPUBxErhK=E2tM=6L-yMLA_L3+ntj3nQ@mail.gmail.com>
References: <1364397694-14126-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdYgCxf9R1aU2QdPUBxErhK=E2tM=6L-yMLA_L3+ntj3nQ@mail.gmail.com>
Message-ID: <20130402083829.GB23065@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 10:26:12AM +0200, Linus Walleij wrote:

> I know that Lee's been sending off a large set of regulator patches
> lately, some include alterations to this platform config.

> Maybe it's better to take this patch into the regulator tree if these
> machine configs will come in that way? Also like Lee to have a
> look at this...

If it's touching the board constraints it's likely to have conflicts
with Lee's stuff, yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/1decce6c/attachment-0001.sig>
