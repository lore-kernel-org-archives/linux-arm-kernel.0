From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Mar 2010 23:46:50 +0000
Subject: [PATCH] locomo.c: make irq register access typesafe
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909022427BE@mi8nycmail19.Mi8.com>
References: <201001201110.44583.hartleys@visionengravers.com>
	<f17812d71001201813hf93c33wbfc9f50452ec38fa@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E8E46@mi8nycmail19.Mi8.com>
	<f17812d71001201841w34abc3b5w49b8c2986897dbe8@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E8E4B@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE1909022427BE@mi8nycmail19.Mi8.com>
Message-ID: <20100308234649.GA17662@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 08, 2010 at 06:22:49PM -0500, H Hartley Sweeten wrote:
> Did your locomo irq cleanup patches get lost somewhere?  I see three pending
> patches in linux-next but they did not show up in Linus' tree during the
> merge window.

*All* the trees which I merged into mine have not made it into
mainline - Linus seems to have released -rc1 two days early.

I'm currently uncertain what this means - whether all this work
is going to have to wait for the next merge window.

If it is going to have to wait, there's a lesson in there for
not sending me headache inducing git tree pull requests *after*
the merge window has opened.
