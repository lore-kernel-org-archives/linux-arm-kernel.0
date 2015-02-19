From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Thu, 19 Feb 2015 13:33:18 +0100
Subject: [PATCH 5/6] ASoC: samsung: Extend Snow driver to support max98089
In-Reply-To: <20150219094425.GB3198@finisterre.sirena.org.uk>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-6-git-send-email-afaerber@suse.de>
 <20150219094425.GB3198@finisterre.sirena.org.uk>
Message-ID: <54E5D80E.3020603@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.02.2015 um 10:44 schrieb Mark Brown:
> On Wed, Feb 18, 2015 at 07:25:58PM +0100, Andreas F?rber wrote:
> 
>>  static const struct of_device_id snow_of_match[] = {
>> +	{ .compatible = "google,snow-audio-max98089", },
>>  	{ .compatible = "google,snow-audio-max98090", },
>>  	{ .compatible = "google,snow-audio-max98091", },
>>  	{ .compatible = "google,snow-audio-max98095", },
> 
> Since we completely ignore the CODEC in the property might it not be
> better to just add a plain old snow-audio compatible and bind to that,
> that way we don't need these driver updates?  Just the "snow" bit should
> be enough to know it's one of this class of machines.

Personally I don't mind either way, but I'd rather leave that decision
to Google/Samsung people.

With all those Tegra and Rockchip based Chromebooks popping up, are
there any further Exynos based Chromebooks planned using this driver, or
is it the last of its kind?

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/4aa72b20/attachment.sig>
