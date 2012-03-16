From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 16 Mar 2012 11:02:28 -0700
Subject: [PATCH 2/2] arm: omap3: pm34xx.c: Replace printk() with
 appropriate pr_*()
In-Reply-To: <4F633528.1040305@ru.mvista.com>
References: <1331852833-4357-1-git-send-email-mgreer@animalcreek.com>
 <1331852833-4357-3-git-send-email-mgreer@animalcreek.com>
 <4F633528.1040305@ru.mvista.com>
Message-ID: <20120316180228.GA1894@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 04:42:16PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 16-03-2012 3:07, Mark A. Greer wrote:
> 
> >From: "Mark A. Greer" <mgreer@animalcreek.com>

> >@@ -463,7 +462,7 @@ restore:
> >  	list_for_each_entry(pwrst,&pwrst_list, node) {
> >  		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
> >  		if (state>  pwrst->next_state) {
> >-			printk(KERN_INFO "Powerdomain (%s) didn't enter "
> >+			pr_info("Powerdomain (%s) didn't enter "
> >  			       "target state %d\n",
> 
>    Last line should have been realigned I think.

Okay, I'll fix this and the others in a bit.

Mark
--
