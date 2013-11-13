From: giometti@enneenne.com (Rodolfo Giometti)
Date: Wed, 13 Nov 2013 18:46:24 +0100
Subject: [RFC PATCH v2] ARM: at91: add support for Cosino board series by
 HCE Engineering
In-Reply-To: <1384364070-32306-1-git-send-email-nicolas.ferre@atmel.com>
References: <1383754767-5398-1-git-send-email-giometti@linux.it>
 <1384364070-32306-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20131113174624.GC10964@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 06:34:30PM +0100, Nicolas Ferre wrote:
> From: Rodolfo Giometti <giometti@linux.it>
> 
> This patch adds the Cosino at91sam9g35 based CPU module and the
> Cosino Mega 2560 extension board.
> 
> Web site: http://www.cosino.it
> 
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> [nicolas.ferre at atmel.com: adapted to newer kernel, modified commit message]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Rodolfo,
> 
> Can you please review this adaptation of your previous patch to newer kernel.
> I hope to integrate your board in upcoming 3.14.
> 
> You will see that I addressed the remarks by Jean-Christophe and Russell (about
> commit message). Please tell me if it is good on your side.

I did some changes... attached are the correct patches.

Here the changelog V1 -> V2:

[Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>]
* prefix "at91-" added
* atmel,mux-mask stuff removed
* "compatible" stuff is now on the same line for easy-grep(TM)
* lcd binding dropped

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm-mach-at91-add-support-for-Cosino-board-series-by.patch
Type: text/x-diff
Size: 6038 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/0b99b342/attachment.bin>
