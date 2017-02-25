From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 26 Feb 2017 00:06:08 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
In-Reply-To: <9a2d6751-d7c3-458f-d717-2abe492e226d@openwrt.org>
References: <20170223104025.5755-1-zajec5@gmail.com>
 <bd36df47-cefe-5736-e02c-621a21ae1b7a@openwrt.org>
 <CACna6rzN-OQv4UJoRso_Kyf1rCEtuU5Lu9LDjvTTt011UgrA=Q@mail.gmail.com>
 <5c57772b-71fd-d9e2-efe6-1175cf048e0b@openwrt.org>
 <CACna6ryFQHGN6xYiLcp9-v7f+55-4hoq+6kXCjiT6LJOS70sQQ@mail.gmail.com>
 <CACna6rzn3YDBqwReEikqjfhpMk-uQj0cuNaay2HyK0kLc_xuJg@mail.gmail.com>
 <9a2d6751-d7c3-458f-d717-2abe492e226d@openwrt.org>
Message-ID: <CACna6rwdC+6DrKK4Zpp7t+W9w1H-Rzj+N3ANaZRAL_GP6JFO2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2017 at 23:43, Imre Kaloz <kaloz@openwrt.org> wrote:
> On 2017-02-24 07:10, Rafa? Mi?ecki wrote:
>>>>
>>>> Your manners shine on these dark days of winter. For about a decade now,
>>>> http://192.168.1.1/sysinfo.cgi will show you quite a bit of information
>>>> if
>>>> you are too lazy to look into the GPL tarball or at the original
>>>> bootlogs.
>>>
>>> Today I decided to do my homework & check GPL sources of EA9500 fw.
>>>
>>> (...)
>>>
>>> Will you be so generous to tell us how did you get EA9500 board name
>>> by just looking at GPL sources?
>>
>> I also tried find with -name "*panamera*". One way of guessing board
>> name seems to be checking names of patches in ./src/linux/patches/.
>> Any other, more reliable method?
>>
>
> First of all, it's really weird you never ever looked at the factory
> bootlogs, but let me help in hope to enhance your communication style:
>
> filenames:
>
> src/linux/patches/linux-2.6.36.4-panamera_000_BSP.patch
> src/linux/patches/linux-2.6.36.4-panamera_001_brcm_build.patch
> src/linux/patches/linux-2.6.36.4-panamera_002_brcm_build_flags_temp_fix.patch
> src/linux/patches/linux-2.6.36.4-panamera_003_ctf_bypass.patch
> src/linux/patches/linux-2.6.36.4-panamera_006_cisco_comment.patch
> src/linux/patches/linux-2.6.36.4-panamera_007_usb_remove_oops.patch
> src/linux/patches/linux-2.6.36.4-panamera_008_6rd_sit_fragment.patch
> src/linux/patches/linux-2.6.36.4-panamera_009_cisco_rtsp_conntrack.patch
> src/linux/patches/linux-2.6.36.4-panamera_010_cisco_rtsp_conntrack2.patch
> src/linux/patches/linux-2.6.36.4-panamera_014_ftp_pasv_command.patch
> src/linux/patches/linux-2.6.36.4-panamera_046_sip_alg.patch
> src/linux/patches/linux-2.6.36.4-panamera_047_add_usb_led.patch
> src/linux/patches/linux-2.6.36.4-panamera_050_PPTP_L2TP_ctf.patch
> src/linux/patches/linux-2.6.36.4-panamera_052_cfe_pass_led_to_blink.patch
> src/linux/patches/linux-2.6.36.4-panamera_201_brcm_patch_20160226.patch
>
> file contents:
>
> src/mod_bdutil/platform/brcm/.board_id.o.cmd
> src/mod_bdutil/platform/brcm/.buttons.o.cmd
> src/mod_bdutil/platform/brcm/.leds_panamera.o.cmd
> src/mod_bdutil/platform/brcm/.usbhub.o.cmd
>
>
> If you have further questions, feel free to mail me directly and keep
> off-topic discussion away from the lists.

Thanks

-- 
Rafa?
