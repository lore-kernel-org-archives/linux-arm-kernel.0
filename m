From: geoff@infradead.org (Geoff Levand)
Date: Thu, 19 Jun 2014 11:07:48 -0700
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <20140619102526.GA22217@leverpostej>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke> <20140618164927.GA9612@leverpostej>
 <1403116902.17030.15.camel@smoke> <20140619102526.GA22217@leverpostej>
Message-ID: <1403201268.17030.59.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, 2014-06-19 at 11:25 +0100, Mark Rutland wrote:
> I disagree that the bootloader _must_ have to deal with the endianness
> of the kernel. If the user knows the endianness of the kernel and
> provides a filesystem of the appropriate endianness, I don't see why the
> bootloader should have to do anything differently. In most cases the
> bootloader has no need to care.

As I mentioned, I don't really care how this is fixed, but there will be
bootloaders built as both big and little endian (kexec based ones for
example), and so no matter what, bootloaders will need to deal with
converting values.

-Geoff
