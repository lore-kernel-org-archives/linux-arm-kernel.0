From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 13:02:42 +0000
Subject: [PATCH v3 00/12] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
References: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130328130242.GZ18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 09, 2013 at 09:23:09PM +0100, Tomasz Figa wrote:
> This series is an attempt to make the samsung-time clocksource driver ready
> for multiplatform kernels. It moves the driver to drivers/clocksource, cleans
> it up from uses of static platform-specific definitions, simplifies timer
> interrupt handling and adds Device Tree support.
> 
> Tested on a Tiny6410 board (Mini6410-compatible) both with and without Devicee
> Tree (with my DT patches for S3C64xx). Compile tested for other related SoCs.

With current -next this seems to break my s3c64xx based system in a
non-DT configuration - this may be due to other work on the clocksources
in -next, I've not really made much effort to investigate.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/c0361201/attachment-0001.sig>
