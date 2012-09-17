From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Mon, 17 Sep 2012 10:58:50 +0200
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <505372E0.1040906@mvista.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
 <1347639843-32119-3-git-send-email-dciminaghi@mail.gnudd.com>
 <505372E0.1040906@mvista.com>
Message-ID: <20120917085850.GE17079@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 10:09:36PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/14/2012 08:23 PM, Davide Ciminaghi wrote:
> 
> > From: Alessandro Rubini <rubini@gnudd.com>
> 
> > Patch dece904d itroduced chained_irq_enter/exit, which is only
> 
>   Rather commit dece904d. And you need to also specify its summary in parens.
>
ok, will fix this

Thanks and regards
Davide
