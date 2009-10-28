From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Oct 2009 10:05:28 +0100
Subject: staging/dream: add gpio and pmem support
In-Reply-To: <4AE807F8.2040909@gmail.com>
References: <20091022091333.GA31023@elf.ucw.cz>
 <4AE807F8.2040909@gmail.com>
Message-ID: <20091028090528.GB18290@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-10-28 10:59:36, Paulius Zaleckas wrote:
> On 10/22/2009 12:13 PM, Pavel Machek wrote:
> >
> >This adds generic_gpio and pmem support, both are needed for other
> >dream drivers.
> 
> Why you are not using existing gpiolib? That would make your driver a
> lot smaller and cleaner... and possibly with less bugs...

That can be cleaned up later.

> Why not split gpio and pmem into separate patches?

General overload? Can you help?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
