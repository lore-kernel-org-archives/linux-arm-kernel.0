From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 23 May 2013 09:29:16 -0700
Subject: [PATCH] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
In-Reply-To: <AAD401B65941D44692B7183E6577180803A11B7C@banasiexm01.ASIA.ROOT.PRI>
References: <1369239198-11059-1-git-send-email-Baohua.Song@csr.com>
 <AAD401B65941D44692B7183E6577180803A11B7C@banasiexm01.ASIA.ROOT.PRI>
Message-ID: <20130523162916.GB15494@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Madhvapathi,

On Thu, May 23, 2013 at 01:49:10PM +0000, Madhvapathi Sriram wrote:
> Possible mem leak here not freeing any allocated devices/memory/irq.
> I suggest all the error handling be collated at the end of this
> function for various stages and error handling be done there.
> Please have a look at
> https://www.kernel.org/doc/Documentation/input/input-programming.txt

Please note that the driver uses managed resources which get cleaned
automatically.

Also, could you please use a sane mailer that wraps long lines properly.

Thanks.

-- 
Dmitry
