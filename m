From: nickpelling@nanodome.com (Nick Pelling)
Date: Wed, 20 Apr 2011 08:46:41 +0100
Subject: Cleanup Samsung stuff
In-Reply-To: <012801cbfe33$a76fa490$f64eedb0$%kim@samsung.com>
References: <012801cbfe33$a76fa490$f64eedb0$%kim@samsung.com>
Message-ID: <9fibsi$eg5ubh@out1.ip07ir2.opaltelecom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

At 10:46 19/04/2011 +0900, Kukjin Kim wrote:
>As a note, I'm doing(or preparing) following at the moment.
>- Removing some "mach-s5pxxxx"s

Are you planning to remove mach-s5pc100? If yes, is this with the 
intention of reducing arch/arm code size (by merging, say, with the 
s5pc110 tree), or because of some upcoming Samsung EOL event? :-(

(I'm building security cameras based on the s5pc100, working with 
mach-s5pc100 issues every day).

Best regards, ....Nick Pelling.... 
