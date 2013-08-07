From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 Aug 2013 10:37:50 +0200
Subject: linux-next: build failure after merge of the mvebu tree
In-Reply-To: <20130807142501.79fea47cae17a6a25f1e719e@canb.auug.org.au>
References: <20130807142501.79fea47cae17a6a25f1e719e@canb.auug.org.au>
Message-ID: <20130807103750.743b389a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Rothwell,

On Wed, 7 Aug 2013 14:25:01 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mvebu tree, today's linux-next build
> (x86_64 allmodconfig) failed like this:
> 
> arch/x86/kernel/x86_init.c:115:22: error: 'default_restore_msi_irqs' undeclared here (not in a function)
>   .restore_msi_irqs = default_restore_msi_irqs,
>                       ^

Thanks Stephen, I'm looking into this.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
