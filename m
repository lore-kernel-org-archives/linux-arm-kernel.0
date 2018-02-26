From: daniel.baluta@gmail.com (Daniel Baluta)
Date: Mon, 26 Feb 2018 16:02:22 +0200
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <20180226131318.GA14045@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
Message-ID: <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 3:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> JFYI: This issues is tracked in the regression reports for Linux 4.16
>> (http://bit.ly/lnxregrep416 ) with this id:
>>
>> Linux-Regression-ID: lr#4b650f
>
> Ok, so it seems that issue is bigger: whole sound subsystem does not
> work. /proc/asound/cards is empty.
>
> 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
>
> I tried to revert sound/soc changes, and sound is broken, too. Nasty


dmesg log?
