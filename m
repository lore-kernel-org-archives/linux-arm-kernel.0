From: bp@alien8.de (Borislav Petkov)
Date: Tue, 8 Jul 2014 13:54:58 +0200
Subject: [PATCHv7 3/3] edac: altera: Add EDAC support for Altera SoC
 SDRAM Controller.
In-Reply-To: <20140708115205.GA8628@amd.pavel.ucw.cz>
References: <1403730927-16163-1-git-send-email-tthayer@altera.com>
 <1403730927-16163-4-git-send-email-tthayer@altera.com>
 <20140708113109.GC8100@amd.pavel.ucw.cz>
 <20140708114227.GB27659@pd.tnic>
 <20140708115205.GA8628@amd.pavel.ucw.cz>
Message-ID: <20140708115458.GC27659@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 01:52:05PM +0200, Pavel Machek wrote:
> I'm not joking. Try to understand and verify the code above. You
> can't. The "descriptive macro names" are useless; all the code does is
> split register in pieces. With the numbers it would be  very obvious.

No, you need to fix the names not switch to naked numbers.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
