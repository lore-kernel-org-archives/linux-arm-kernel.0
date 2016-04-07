From: tthayer@opensource.altera.com (Thor Thayer)
Date: Wed, 6 Apr 2016 19:36:49 -0500
Subject: [PATCHv2 6/7] ARM: socfpga: Enable Arria10 OCRAM ECC on startup
In-Reply-To: <20160405053110.GA17541@pd.tnic>
References: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
 <1459450087-24792-7-git-send-email-tthayer@opensource.altera.com>
 <57034C4D.9010204@opensource.altera.com> <20160405053110.GA17541@pd.tnic>
Message-ID: <5705ABA1.4000308@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 04/05/2016 12:31 AM, Borislav Petkov wrote:
> On Tue, Apr 05, 2016 at 12:25:33AM -0500, Thor Thayer wrote:
>> I realize that I'm not calling iounmap(ecc_block_base) and I'll fix that in
>> the next revision with a goto.
>
> I'm assuming nothing else changes. Because I've applied 1-4 already.
>
> Yes, no?
>
> If no, then please send only an updated version of this patch as a reply
> to this thread here.
>
> Thanks.
>
Yes, nothing else changes. The rest was OK. Thanks!
