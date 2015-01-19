From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 19 Jan 2015 11:34:21 +0100
Subject: [PATCH 1/2] pinctrl: at91: allow disabled gpio controllers
In-Reply-To: <CACRpkdZ0X_9TX_R7OJJxNynBq0gZd8i_iUE11VXtiKSN+uqpmQ@mail.gmail.com>
References: <1417193367-12422-1-git-send-email-ludovic.desroches@atmel.com>
 <20150114204512.GB14457@ns203013.ovh.net>
 <CACRpkdZ0X_9TX_R7OJJxNynBq0gZd8i_iUE11VXtiKSN+uqpmQ@mail.gmail.com>
Message-ID: <20150119103421.GC19014@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 11:16:30AM +0100, Linus Walleij wrote:
> On Wed, Jan 14, 2015 at 9:45 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> 
> > attached a patch we the idea how to handle the current issue
> > only compiled not tested (too late here)
> 
> Ludovic have you tested Jean-Christophe's patch?
> 
> Does it solve the boot issue?

Yes I have tested it. I have send a new version since it doesn't totally
solved the boot issue. It corrects some potential problems I have missed
but there is still an error in the pinctrl probe.

Regards

Ludovic
