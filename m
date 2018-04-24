From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 24 Apr 2018 12:01:48 +0200
Subject: [PATCH 2/2] ARM64: dts: allwinner: Add dts file for Libre
 Computer Board ALL-H3-CC H5 ver.
In-Reply-To: <20180424095914.cs362x4zdwxzo6ru@flea>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-3-git-send-email-narmstrong@baylibre.com>
 <20180424095914.cs362x4zdwxzo6ru@flea>
Message-ID: <a883629c-4533-e457-d108-0bd307392ec8@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/2018 11:59, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Apr 24, 2018 at 11:19:36AM +0200, Neil Armstrong wrote:
>> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
>> Pi B+ form factor single board computer based on the Allwinner H2+, H3, or H5
>> SoCs with the same PCB.
>> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
>> and connectors are in the exact same position as on the Raspberry Pi B+.
>>
>> This patch enables the H5 variant using the H3 board definition moved to
>> a common dtsi in an earlier patch. The dts simply include the common dtsi
>> and declares the correct compatible and model of the H5 variant.
>>
>> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> prefix should be "arm64: dts: allwinner"

Bad habit, will resend with arm64.

> 
> You had this issue with the first patch as well, your commit log
> should be wrapped, checkpatch complains at the moment.

Same.

> 
> Maxime
> 

Thanks,
Neil

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/dfa3dbf2/attachment-0001.sig>
