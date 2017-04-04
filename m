From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 4 Apr 2017 11:18:51 +0200
Subject: [PATCH v2 13/13] MAINTAINERS: update files for Amlogic DRM Driver
In-Reply-To: <20170404090124.vn5keeanafpwzcap@phenom.ffwll.local>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
 <1490109950-21421-14-git-send-email-narmstrong@baylibre.com>
 <20170404090124.vn5keeanafpwzcap@phenom.ffwll.local>
Message-ID: <6ea12eab-2f51-787d-74c8-ddd35f2b356f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2017 11:01 AM, Daniel Vetter wrote:
> On Tue, Mar 21, 2017 at 04:25:50PM +0100, Neil Armstrong wrote:
>> This patch adds the dw-hdmi bindings and RST kerneldoc to maintained files.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e88154f..3df68c73 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4256,6 +4256,8 @@ W:	http://linux-meson.com/
>>  S:	Supported
>>  F:	drivers/gpu/drm/meson/
>>  F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
>> +F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
>> +F:	Documentation/gpu/meson.rst
>>  T:	git git://anongit.freedesktop.org/drm/drm-meson
> 
> As discussed on irc, pls also remove the drm-meson git repo here (and ask
> fdo admins to can it). To avoid confusion.

Ok, I already removed the line and pushed it to drm-misc-next,
I'll certainly need to fix a conflict here when pushing this one to drm-misc-next.

> -Daniel
> 
>>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>>  
>> -- 
>> 1.9.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
