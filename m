From: rah@settrans.net (Bob Ham)
Date: Tue, 5 Jun 2018 19:18:48 +0100
Subject: [linux-sunxi] Re: [PATCH v2] arm: sun4i: Add support for Pengpod
 1000 tablet
In-Reply-To: <20180605145038.qptdlcphdbnw6jyg@flea>
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
 <20180605145038.qptdlcphdbnw6jyg@flea>
Message-ID: <e2787b2a-230d-ea3c-89b9-316ddcd20f67@settrans.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/18 15:50, Maxime Ripard wrote:
> On Mon, Jun 04, 2018 at 06:33:02PM +0100, Bob Ham wrote:
>> On 04/06/18 09:13, Maxime Ripard wrote:
>>> On Sat, Jun 02, 2018 at 05:03:13PM +0100, Bob Ham wrote:
>>
>>>> + * This file is dual-licensed: you can use it either under the terms
>>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>>> + * licensing only applies to this file, and not this project as a
>>>> + * whole.
>>
>>>> + *     The above copyright notice and this permission notice shall be
>>>> + *     included in all copies or substantial portions of the Software.
>>
>>> And this is redundant with the SPDX header.
>>
>> The X11 license notice states explicitly that the notice has to be
>> included in the file.  Wouldn't removing it be a violation of the license?
> 
> The SPDX header is explicitly here to remove the license text and
> create a tag that is in a indirect reference to the license text in
> LICENSES. It's not going away.

Well, the top bit that I quoted above says that the licenses refer to
only that one file in particular and not the project as a whole.  Then
the X11 license states that the notice can't be removed from 'this
software and associated documentation files (the "Software")' which
would seem to refer to the single file.  Therefore, removing the notice
from the single file and replacing it with an SPDX header would seem to
violate the license.

It's a fine point but it makes me nervous.  I originally based my .dts
on sun4i-a10-inet1.dts.  I've CC'd the original copyright holder, Hans
de Goede.  Hans, are you willing to give permission for the license
notice to be replaced with just an SPDX header indicating the dual
licensing?

While we're at it, there are a number of other files with the same
license text.  Hans, are you prepared to give permission for your other
license notices to be replaced with SPDX headers?

Thanks,

Bob

-- 
Bob Ham <rah@settrans.net>

for (;;) { ++pancakes; }

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 2913 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/c91f541e/attachment.sig>
