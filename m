From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2016 20:01:08 +0000
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <CAKv+Gu8ZTHAqviveLMizRKPfeXwb6kcXi4cVQNYVYuPcVMgMeQ@mail.gmail.com>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <HKXPR06MB0565A2CFF95AD7C000F43E6A8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu9VvskQ34w0niS+6AtF9hNcycfYDt_3Kp4T+WK8Vxf_dA@mail.gmail.com>
 <HKXPR06MB05656F902E0E1FBBDBD713DC8AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu8ZTHAqviveLMizRKPfeXwb6kcXi4cVQNYVYuPcVMgMeQ@mail.gmail.com>
Message-ID: <20160203200107.GD10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 02:41:29PM +0100, Ard Biesheuvel wrote:
> > bf353edc T __stubs_start
> 
> This is a global symbol
> 
> > bf353edc T _etext
> > bf353ee0 t __stubs_start
> 
> This is a local symbol

Stop this madness.  This gets you an immediate NAK on the patch set.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
