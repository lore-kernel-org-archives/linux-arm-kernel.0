From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 3 Jun 2015 10:35:22 +1000
Subject: [linux-sunxi] [PATCH] ARM: dts: sun8i: Add dts file for the
 GA10H-A33 tablet
In-Reply-To: <CAKON4OxsJO28aDMCvFzx_Z9n=Hyq6uBYo3hWR+04YDwjJVcTnA@mail.gmail.com>
References: <1433274598-17366-1-git-send-email-hdegoede@redhat.com>
 <CAKON4OxsJO28aDMCvFzx_Z9n=Hyq6uBYo3hWR+04YDwjJVcTnA@mail.gmail.com>
Message-ID: <CAGRGNgVTuik13PG41tebjfPkGfyDVZw54hGgMH79bpeT1mCOiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 3, 2015 at 6:20 AM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> Resend with plain text for image links....
>
> I have one of these GA10H-A33 and tore it apart. They used an uncommon
> wifi/BT chip - RDA5990P. Took mine apart since the wifi didn't work worth
> two cents.
> http://www.rdaic.com/sites/default/files/public/RDA5990P_datasheet_V1.4.pdf
>
> Is that unpopulated pad next to the RSA5990P an option to use an Ampak
> module? I am looking for a A33 PCBA where I can mount a 5Ghz wi-fi module.

Potential driver:
https://github.com/linuxium/3188-SRC-ORIG/tree/master/kernel/drivers/net/wireless/rda5990

(Code implies GPL but is missing copyright / license notices, might be
for an older part.)

On an unrelated note, is MediaTek buying up every last small
manufacturer of WiFi parts?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
