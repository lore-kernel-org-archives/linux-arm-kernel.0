From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Wed, 14 Jan 2015 08:02:25 +0100
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <CAEUnVG727F16K2kMWCrPHXTZgpc_4gnCBkF=Aa_zaJiSMviy=g@mail.gmail.com>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <CAAObsKCbJLwEHeiv3DbCwsiVSZ0VDGzU84+ipPKJQZajx+KiuQ@mail.gmail.com>
 <CAEUnVG727F16K2kMWCrPHXTZgpc_4gnCBkF=Aa_zaJiSMviy=g@mail.gmail.com>
Message-ID: <CAAObsKBo13fEy72EQe3V409fEEYpw0kQss5UgaOhk=GOVEEeYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2015 at 01:32, Dylan Reid <dgreid@chromium.org> wrote:
> On Tue, Jan 13, 2015 at 9:49 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>> On 13 August 2014 at 03:56, Dylan Reid <dgreid@chromium.org> wrote:
>>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>>> processor and is similar to the Venice2 reference platform.
>>>
>>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>>> and work on the 1366x768 models.  I haven't tried on the HD systems
>>> yet.
>>
>> Hi Dylan,
>>
>> do you have any notes on how you tested audio? I have been fiddling a
>> bit with amixer but haven't been able to get any sound from the
>> speakers nor the headphones.
>
> I don't have any notes, and it's been a while since I tried it.  To
> the best of my knowledge, I loaded the UCM config from the ChromeOS
> tree manually with alsaucm, then enabled/disabled headphones from
> there.
>
> https://chromium.googlesource.com/chromiumos/third_party/adhd/+/master/ucm-config/nyan/NVIDIA%20Tegra%20Venice2/
>
> The important stuff is all in the enable sequence of HiFi.conf
>
> Let me know if that helps.

Thanks, it does work fine now. Will submit that conf file upstream.

Tomeu
