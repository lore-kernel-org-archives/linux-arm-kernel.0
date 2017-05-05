From: stefan@agner.ch (Stefan Agner)
Date: Fri, 05 May 2017 16:52:12 -0700
Subject: [PATCH 1/5] ARM: dts: imx7-colibri: use OF graph to describe the
 display
In-Reply-To: <CAOMZO5AuvgqtNTHUW-LyXy9Xsq=rnaPODBzWA3FRmRpxqrRqAw@mail.gmail.com>
References: <20170329232113.19078-1-stefan@agner.ch>
 <CAOMZO5Bp=K8_nP0_+MjQ9teS_U9SpRspOhVPwOwg1J0m0QZjCg@mail.gmail.com>
 <CAOMZO5AuvgqtNTHUW-LyXy9Xsq=rnaPODBzWA3FRmRpxqrRqAw@mail.gmail.com>
Message-ID: <144548a963c8393049f90afd683b331b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-05 06:18, Fabio Estevam wrote:
> On Fri, May 5, 2017 at 8:48 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
>> Could you please confirm that drm/mxsfb is working fine on 4.11 on your board?
>>
>> I am converting mx6sx sdb to use drm/mxsfb and I noticed that when
>> board boots I get garbage on the display.
>>
>> If I do a blank/unblank then things are displayed correctly.
> 
> Ok, I managed to fix the drm/mxsfb driver.
> 
> Will submit a patch shortly.

FWIW, it works, on i.MX 7 here, but I also have a U-Boot which
initialized eLCDIF first.

Will check your patch and without U-Boot eLCDIF support.

--
Stefan
