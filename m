From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 11:25:32 +0100
Subject: [linux-sunxi] Re: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi:
 Fix VBP size calculation
In-Reply-To: <55900bf3-efb5-5f78-5252-b3f6d4f775fb@openedev.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com>
 <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
 <20181120155715.andrjp5kg6ugcv72@flea>
 <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
 <55900bf3-efb5-5f78-5252-b3f6d4f775fb@openedev.com>
Message-ID: <20181127102532.6wuwrhvk256g7kbm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 05:37:09PM +0530, Jagan Teki wrote:
> I'm about to send next version by combining with burst mode changes in
> one series. Do you have any further inputs on this. I didn't not see
> any breakage with 4-lane devices, but has issue with 2-lane w/o this change.

I'd rather focus on one thing for now. When your A64 DSI series will
be in, then you can focus on the burst mode.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/a5b7ef7f/attachment.sig>
