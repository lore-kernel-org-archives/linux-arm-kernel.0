From: maggu2810@gmail.com (Markus Rathgeb)
Date: Sun, 11 Feb 2018 14:47:31 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <CAOcK=CMFahBh9rmm5PGHe=UVrdxi_pwWH=cOs9Q_kCgzTTKOew@mail.gmail.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <CAOcK=CMFahBh9rmm5PGHe=UVrdxi_pwWH=cOs9Q_kCgzTTKOew@mail.gmail.com>
Message-ID: <CAOcK=CMoVd=nWQd1pyCM4J0YXpMj1i4+nn4o60tPZfntwFm8AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

have you seen my message from

2018-01-20 10:14 GMT+01:00 Markus Rathgeb <maggu2810@gmail.com>:
>
>
> I tested the patch that sets usbh1's status to disable using the
> kernel 4.13 that previously hangs.
> I confirm the disabled usb host allows to boot my imx6q-udoo board.
>
> Tested-by: Markus Rathgeb <maggu2810@gmail.com>

or missed I some further messages on that topic?

With your changes the board will boot again, so a step forward (but
USB will not working).

I recently read the "Linux Kernel Release Model"
(http://kroah.com/log/blog/2018/02/05/linux-kernel-release-model/) and
stumbled about that sentence: "The Linux kernel community has promised
its userbase that no upgrade will ever break anything that is
currently working in a previous release."
I used the Udoo board a long time for my USB printer to access it over
the network. So USB has been working in a release but does not work
anymore.
"Regressions do happen, but those are the highest priority bugs and
are either quickly fixed, or the change that caused the regression is
quickly reverted from the Linux kernel tree."
So, can we expect that USB will be working soon again or are such
boards an exception to that overcome?

Best regards,
Markus
