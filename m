From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 28 Nov 2017 22:53:42 +0100
Subject: [PATCH 1/4] ARM: pxa/corgi: Remove hardcoded partitioning,
 use sharpslpart parser
In-Reply-To: <1511300631-1343-1-git-send-email-andrea.adami@gmail.com> (Andrea
 Adami's message of "Tue, 21 Nov 2017 22:43:48 +0100")
References: <1511300631-1343-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <87a7z66peh.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrea Adami <andrea.adami@gmail.com> writes:

> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, with
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done here in the board file.
>
> Emulators like qemu will need to pass the mtdparts in the cmdline.
>
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>

Applied to whole serie to pxa/for-next, thanks.

Cheers.

--
Robert
