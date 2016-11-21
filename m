From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 21 Nov 2016 18:29:51 +0100
Subject: [PATCH] drm: tilcdc: reduce max_width for revision 1
In-Reply-To: <2013ba47-e7e4-045e-0232-4ebd7450c3ad@ti.com>
References: <1479748590-3962-1-git-send-email-bgolaszewski@baylibre.com>
 <1479748590-3962-2-git-send-email-bgolaszewski@baylibre.com>
 <2013ba47-e7e4-045e-0232-4ebd7450c3ad@ti.com>
Message-ID: <CAMpxmJVVG_s-BtR5c+P4YqbX8BbnmQR2yQHsBt70Qq0mmq_pXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-21 18:26 GMT+01:00 Jyri Sarha <jsarha@ti.com>:
> On 11/21/16 19:16, Bartosz Golaszewski wrote:
>> It has been determined that the highest resolution supported correctly
>> by LCDC rev1 is 800x600. Reduce the max_width value for rev1 to 800 in
>> crtc_max_width().
>>
>
> I don't think this is the right way to limit the supported video modes.
> There is technically there is no such limit, is there?
>
> If memory bandwidth is limiting the functionality of higher resolutions,
> you should use "max-bandwidth" tilcdc device-tree property [1].
>
> Cheers,
> Jyri
>

Will do, thanks.

Bartosz Golaszewski
