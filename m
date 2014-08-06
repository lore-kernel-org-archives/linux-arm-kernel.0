From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 6 Aug 2014 15:55:03 +0100
Subject: [PATCH 1/2] UEFI arm64: add noefi boot param
In-Reply-To: <20140806144839.GK4179@bivouac.eciton.net>
References: <20140806083825.GA31711@dhcp-16-198.nay.redhat.com>
 <20140806130623.GI4179@bivouac.eciton.net>
 <20140806132021.GB15082@console-pimps.org>
 <20140806132941.GJ4179@bivouac.eciton.net>
 <20140806140155.GC15082@console-pimps.org>
 <CAKv+Gu8ey1iKu-_wS6yYaEXQaQMDXa+PF5Kiw+edA9a_OE1EAw@mail.gmail.com>
 <20140806141814.GD15082@console-pimps.org>
 <20140806144839.GK4179@bivouac.eciton.net>
Message-ID: <20140806145503.GF15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Aug, at 03:48:39PM, Leif Lindholm wrote:
> 
> Since we're now overlaying two different meanings onto the
> EFI_RUNTIME_SERVICES bit, could we add comments at set/clear points to
> explicitly state the intended action? I.e.:
> 
> /* Set to attempt runtime services initialisation */
> 
> /* Clear to indicate runtime services will not be available */

Good idea.

My patch was only a hack to show how it's possible to use efi_enabled().
It may require some finessing ;-)

-- 
Matt Fleming, Intel Open Source Technology Center
