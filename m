From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 2 Feb 2017 14:04:15 +0100
Subject: [PATCH v2] Documentation: devicetree: meson-ir:
 "linux,rc-map-name" is supported
In-Reply-To: <CAFBinCDF2d36E2hp7w_ehqdErdZPK9maQLpBmqMoGMPZmTTqqQ@mail.gmail.com>
References: <20170131212112.5582-1-martin.blumenstingl@googlemail.com>
 <20170201221415.22794-1-martin.blumenstingl@googlemail.com>
 <CAFBinCDF2d36E2hp7w_ehqdErdZPK9maQLpBmqMoGMPZmTTqqQ@mail.gmail.com>
Message-ID: <cccd0fef-fa2c-bdfd-b7dd-b26ef288dfa0@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.02.2017 um 23:26 schrieb Martin Blumenstingl:
> On Wed, Feb 1, 2017 at 11:14 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> The driver already parses the "linux,rc-map-name" property. Add this
>> information to the documentation so .dts maintainers don't have to look
>> it up in the source-code.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>> Changes since v1:
>> - removed character which shows up as whitespace from subject
> I have verified that I really sent this without a whitespace (I'm
> using git send-email, so the patch is not mangled by some webmailer) -
> unfortunately it seems to appear again (maybe one of the receiving
> mail-servers or the mailing-list software does something weird here).

Shows up fine here now,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Didn't expect a resend for that btw.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
