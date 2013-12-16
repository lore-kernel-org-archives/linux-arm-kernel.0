From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 21:09:15 +0000
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to
 double clock initialization
In-Reply-To: <1500417.9RFCmzklxv@flatron>
References: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
 <CAOesGMifjnTDUcsweOwsw9fFgsE7b4q3wsASfP8YL-uMH5KiPA@mail.gmail.com>
 <CAPTRvHn7yTt6mC1fjEn5Ra9yx=GZ1DyNQtGWvHsDd_LkuiM_wA@mail.gmail.com>
 <1500417.9RFCmzklxv@flatron>
Message-ID: <20131216210915.GD3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 04:41:06AM -0800, Tomasz Figa wrote:

>  - Wolfson Cragganmore 6410 - Mark Brown (copied) is using it for some
>    testing of audio codec AFAIK, but I'm not sure if you can get that
>    anywhere.

Essentially no, though you could try asking nicely.  It's not suitable
for a test farm anyway without a SD mux as the only bootloader supported
is Qi which only boots from flash.

>  - SMDK6400/SMDK6410 are Samsung's official development boards for
>    S3C6400/S3C6410 - I have access to one at the office; no idea if
>    you can get one anywhere,

I believe they're no longer available though ICBW.  The cost for low
volume orders is likely to be a bit high too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/fdf10a37/attachment.sig>
