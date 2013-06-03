From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Jun 2013 10:15:22 -0400
Subject: [PATCHv3 0/3] Add G762/G763 PWM fan controller
In-Reply-To: <20130603023053.GA11723@roeck-us.net>
References: <cover.1370202835.git.arno@natisbad.org>
 <20130603023053.GA11723@roeck-us.net>
Message-ID: <20130603141522.GE3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 07:30:53PM -0700, Guenter Roeck wrote:
> On Sun, Jun 02, 2013 at 10:14:05PM +0200, Arnaud Ebalard wrote:
...
> > note: this should not be an issue but this v3 is based on
> >       jcooper/mvebu/fixes branch. 
> > 
> I don't know about this branch/repository. If there are hwmon fixes in it,
> they should be submitted to the lm-sensors mailing list.

Yes, please, unless you *need* a patch to build/boot that isn't in
mainline yet, always base off of one of Linus' tags, eg v3.10-rc4.  Then,
if asked, rebase as needed.

thx,

Jason.
