From: giometti@enneenne.com (Rodolfo Giometti)
Date: Thu, 14 Nov 2013 11:20:56 +0100
Subject: [RFC PATCH v2] ARM: at91: add support for Cosino board series by
 HCE Engineering
In-Reply-To: <52849021.4060809@atmel.com>
References: <1383754767-5398-1-git-send-email-giometti@linux.it>
 <1384364070-32306-1-git-send-email-nicolas.ferre@atmel.com>
 <20131113174624.GC10964@enneenne.com> <52849021.4060809@atmel.com>
Message-ID: <20131114102055.GG10964@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 09:56:01AM +0100, Nicolas Ferre wrote:
> On 13/11/2013 18:46, Rodolfo Giometti :
> >On Wed, Nov 13, 2013 at 06:34:30PM +0100, Nicolas Ferre wrote:
> >>From: Rodolfo Giometti <giometti@linux.it>
> >>
> >>This patch adds the Cosino at91sam9g35 based CPU module and the
> >>Cosino Mega 2560 extension board.
> >>
> >>Web site: http://www.cosino.it
> >>
> >>Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> >>[nicolas.ferre at atmel.com: adapted to newer kernel, modified commit message]
> >>Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>---
> >>Rodolfo,
> >>
> >>Can you please review this adaptation of your previous patch to newer kernel.
> >>I hope to integrate your board in upcoming 3.14.
> >>
> >>You will see that I addressed the remarks by Jean-Christophe and Russell (about
> >>commit message). Please tell me if it is good on your side.
> >
> >I did some changes... attached are the correct patches.
> 
> Doing the diff between our patch I only seen a difference in nand binding:
> nand-on-flash-bbt;
> is present in my adaptation while it is not in yours but I do not
> think it is a problem to keep it.

Well, I tested Cosino's NAND flash without such parameter... however
if you think it could not be a problem you can leave it.

> >Here the changelog V1 -> V2:
> >
> >[Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>]
> >* prefix "at91-" added
> >* atmel,mux-mask stuff removed
> >* "compatible" stuff is now on the same line for easy-grep(TM)
> >* lcd binding dropped
> 
> Absolutely, I will add it to the commit log and integrate in the
> upcoming at91-3.14-dt branch.
> 
> Thanks for your quick feedback. Bye,

Great! Thanks. :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
