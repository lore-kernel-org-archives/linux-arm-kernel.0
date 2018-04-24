From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 24 Apr 2018 12:03:44 +0200
Subject: [PATCH 1/2] ARM: dts: sun8i-h3-libretech-all-h3-cc: Move board
 definition to common dtsi
In-Reply-To: <20180424095656.oormsyru7nw6hypn@flea>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-2-git-send-email-narmstrong@baylibre.com>
 <20180424095656.oormsyru7nw6hypn@flea>
Message-ID: <20d4b1f5-b300-37e2-8dca-e80f691440a9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/2018 11:56, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Apr 24, 2018 at 11:19:35AM +0200, Neil Armstrong wrote:
>> Since the libretech-all-h3-cc can use either the H2+, H3 or H5, move the
>> content of the dts file to a common dtsi file to be included by the H3 variant
>> and in a following patch the H5 variant.
>>
>> By the way, update the SPDX licence tag position.
>>
>> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> This patch looks fine, but doesn't apply anymore. Please resend it.

I based it on 4.17-rc2, should I rebase in your tree ?

> 
> While you're at it, the prefix should be "arm: dts: sun8i: h3:" (with
> arm being lowercase).

Good to know,

> 
> Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/3ab78794/attachment.sig>
