From: rpimentel.silva@gmail.com (Rogerio Pimentel)
Date: Thu, 16 May 2013 12:45:13 -0300
Subject: parallel-display driver for i.MX53
In-Reply-To: <CAOkaPuX7RjwrMiZUCGwXTovgsFf=onRkrGa2U+qUv-tU3t4WWg@mail.gmail.com>
References: <CAOkaPuX7RjwrMiZUCGwXTovgsFf=onRkrGa2U+qUv-tU3t4WWg@mail.gmail.com>
Message-ID: <CAOkaPuUdugB8+qTakh8-N0bsxfobQymbYtCQ67FfX8CuttPb0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

I see that reverting patch

2ea42608ba977bd05ce7b2d8a1f65efacfc84352
staging: drm/imx: Add support for VGA via TVE on i.MX53

The display on LCD/i.MX53QSB shows for about 1 second and turn off.
Have you noticed any kind of problem on parallel displays after your
recent patches?
Could you please confirm that imx-parallel display is functional after
your tve patches are applied?

Rgds
Rogerio Pimentel

On Thu, May 16, 2013 at 11:02 AM, Rogerio Pimentel
<rpimentel.silva@gmail.com> wrote:
> Hi,
>
> I'm trying to add the parallel display on i.MX53QSB but it's not
> working on current linux next. It was working prior to 3.10-rc1.
>
> Does anybody know about any significant change that made this driver
> break? Or maybe something else I need to do on imx53-qsb.dtb?
>
> Thanks,
> Rogerio
