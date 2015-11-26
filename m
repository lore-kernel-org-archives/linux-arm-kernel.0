From: slash.tmp@free.fr (Mason)
Date: Thu, 26 Nov 2015 18:34:12 +0100
Subject: ARCH_MULTIPLATFORM + ARM_APPENDED_DTB + custom boot-loader
In-Reply-To: <20151126171440.GD8644@n2100.arm.linux.org.uk>
References: <565738F7.1060204@free.fr> <56573CEE.10101@free.fr>
 <20151126171440.GD8644@n2100.arm.linux.org.uk>
Message-ID: <56574294.1070100@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/2015 18:14, Russell King - ARM Linux wrote:

> On Thu, Nov 26, 2015 at 06:10:06PM +0100, Mason wrote:
>
>> Question: can a DT be appended to an Image, or does it have to be
>> appended to a zImage?
> 
> The code to deal with it is part of the zImage.
> 
>> Can a zImage be uncompressed or compressed with a null compressor?
> 
> Why?

To minimize the time required to boot on a slow emulator? :-)

> The format of both Image and zImage are mostly identical - you should
> be able to use either with a boot loader wanting a binary image -
> provided things are setup how the kernel wants.  However, as you
> need the appended DT support, you must use zImage.

Thanks. LZ4 is the fastest decompressor, right?

Regards.
