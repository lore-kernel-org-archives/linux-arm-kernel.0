From: ibr@radix50.net (Baurzhan Ismagulov)
Date: Tue, 23 Mar 2010 14:21:09 +0100
Subject: [PATCH] Voipac PXA270
In-Reply-To: <f17812d71003211910u1ae21bc4ofea3bb8b61b41e45@mail.gmail.com>
References: <201003100247.27059.marek.vasut@gmail.com>
	<201003101237.26819.marek.vasut@gmail.com>
	<20100310133529.GK28972@buzzloop.caiaq.de>
	<201003101620.17501.marek.vasut@gmail.com>
	<f17812d71003211910u1ae21bc4ofea3bb8b61b41e45@mail.gmail.com>
Message-ID: <20100323132109.GD9581@radix50.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 10:10:52AM +0800, Eric Miao wrote:
> On Wed, Mar 10, 2010 at 11:20 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Yes, they are used in the PCMCIA driver. And I'd rather avoid having GPIO
> > definitions scattered across multiple files.
> 
> Mmm... that's because PCMCIA driver is not abstracted well enough to
> allow all platform specific stuffs back into board file. Once that's done,
> these shared definitions could be avoided to live in a separate header
> file.

What is the recommended method to abstract that? For example, I have two
boards with different GPIO pins assigned to mean certain external
signals. I also ended up with GPIO definitions in a header, which is
used by the driver, and I'd like to clean this up.

Thanks in advance,
-- 
Baurzhan Ismagulov
http://www.kz-easy.com/
