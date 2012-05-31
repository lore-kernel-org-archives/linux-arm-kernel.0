From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 31 May 2012 09:37:15 +0100
Subject: [PATCH RFC 1/3] i2c-nomadik: move header from <plat/i2c.h> to
 <linux/i2c-nomadik.h>
In-Reply-To: <CACRpkdY_bg5s_eKot8Ywbmb+SmixsJOSJW_jWjjenedjJng4Jg@mail.gmail.com>
References: <cover.1338398567.git.rubini@gnudd.com>
 <ca47a47e0a4db31545549ed978e1dc7b3aad4377.1338398567.git.rubini@gnudd.com>
 <CACRpkdY_bg5s_eKot8Ywbmb+SmixsJOSJW_jWjjenedjJng4Jg@mail.gmail.com>
Message-ID: <4FC72DBB.6030601@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/12 02:47, Linus Walleij wrote:
> On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini<rubini@gnudd.com>  wrote:
>
>> The header and driver were only used by arm/mach-nomadik and
>> arm/mach-u8500.  The STA2X11 I/O Hub exports on PCIe a number of
>> devices, including i2c-nomadik.  This patch allows compilation of
>> the driver under x86.
>>
>> Signed-off-by: Alessandro Rubini<rubini@gnudd.com>
>> Acked-by: Giancarlo Asnaghi<giancarlo.asnaghi@st.com>
>
> The new place to put pure platform data headers is:
> include/linux/platform_data/i2c-nomadik.h so please use this.

Aha, didn't see your reply before making mine.

> Pls use git format-patch -M so we get a nice movement patch
> without all the -/+ lines. (No big deal though.)

Agreed, useful for when actually submitting.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
