From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 19 Jan 2017 09:12:20 +0100
Subject: [PATCH 2/3] ARM64: dts: meson-gxbb: Add support for WeTek Hub and
 Play
In-Reply-To: <m2mveox9mm.fsf@baylibre.com>
References: <1484736642-5451-1-git-send-email-narmstrong@baylibre.com>
 <1484736642-5451-3-git-send-email-narmstrong@baylibre.com>
 <m2mveox9mm.fsf@baylibre.com>
Message-ID: <61c3c24d-57cd-b81d-0225-5aae14352397@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 11:53 PM, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> Adds support for the WeTek Hub and Play2 boards.
>> The Hub is an extremely small IPTv Set-Top-Box and the Play2 is a more
>> traditionnal Satellite or Terrestrial and IPTv Set-Top-Box.
>>
>> Both are based on the p200 Reference Design and out-of-tree support is
>> based on OpenELEC kernel at [1].
>>
>> [1] https://github.com/wetek-enigma/linux-amlogic
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Did you get the GPIO/button info from the LibreELEC tree or did you find
> some schematics someplace?  If you found any schematics, it would be
> nice to have links in the DTS files.
> 
> Kevin
> 

It was in the dts of the LibreELEC tree, I found no schematics so far.
I can respin a v2 with a link to the LibreELEC dts files.

Neil
