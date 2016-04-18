From: bp@alien8.de (Borislav Petkov)
Date: Mon, 18 Apr 2016 22:06:37 +0200
Subject: [PATCH] Add EDAC peripheral init functions & Ethernet EDAC.
In-Reply-To: <20160418200227.GA2057@cz.tnic>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
 <20160414143501.GA25212@rob-hp-laptop>
 <20160415064042.330406ab.m.chehab@samsung.com>
 <5711087A.8050501@opensource.altera.com>
 <20160415214618.GB4545@cz.tnic>
 <5714EEC4.4060807@opensource.altera.com>
 <20160418200227.GA2057@cz.tnic>
Message-ID: <20160418200637.GB2057@cz.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 10:02:27PM +0200, Borislav Petkov wrote:
> >  the number of uncorrectable errors is useful from a system point of
> > view.

I forgot: so altr_edac_a10_ecc_irq() panics on uncorrectable errors. Do we want
to do that even for UEs coming from the network...?

Seems a bit overboard to me...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
