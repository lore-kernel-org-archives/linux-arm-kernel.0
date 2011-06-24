From: zonque@gmail.com (Daniel Mack)
Date: Fri, 24 Jun 2011 22:40:06 +0200
Subject: I can' t compile a new kernel version
In-Reply-To: <1308940265.2194.77.camel@sacarino>
References: <1308940265.2194.77.camel@sacarino>
Message-ID: <BANLkTimugaX+WWM8ynaeQLKR=RYRwuW36A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 8:31 PM, Jorge Yesid Rios Ortiz
<jyrios@die.upm.es> wrote:
> If you have some idea about how to compile a new kernel's version I
> appreciated Very much.

I can recommend the buildroot project to you for such things:

  http://buildroot.uclibc.org/

Assuming that you have an up-to-date Linux on your development box,
using buildroot should be easy. Just select your board configuration
and the packages you need, and buildroot will download, extract and
build everything you need, including a kernel if you want to. For more
information, make sure to read
http://buildroot.uclibc.org/downloads/buildroot.html


HTH,
Daniel
